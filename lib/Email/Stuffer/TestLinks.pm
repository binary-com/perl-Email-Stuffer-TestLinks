package Email::Stuffer::TestLinks;

use strict;
use warnings;

our $VERSION = '0.010';

use Test::Most;
use Mojo::UserAgent;
use Email::Stuffer;
use Class::Method::Modifiers qw/ install_modifier /;

=head1 SYNOPSIS

    use Email::Stuffer::TestLinks;

=head1 NAME

Email::Stuffer::TestLinks - validates links in HTML emails sent by Email::Stuffer>send_or_die()

=head1 DESCRIPTION

When this module is included in a test, it parses HTML links (<a href="xyz"...) in every email sent through 
Email::Stuffer->send_or_die(). Each URI must a successful response code and the returned page title must not 
contain 'error' or 'not found'.

=cut

install_modifier 'Email::Stuffer', after => send_or_die => sub {

    my $self = shift;
    my $ua   = Mojo::UserAgent->new;
    $ua->max_redirects(10);
    $ua->connect_timeout(5);

    my @urls;
    my $body;
    $self->email->walk_parts(
        sub {
            my ($part) = @_;
            if ( $part->content_type && $part->content_type =~ /text\/html/i ) {
                my $dom = Mojo::DOM->new( $part->body );
                my $links = $dom->find('a')->map( attr => 'href' )->compact;

                # Exclude anchors, mailto
                push( @urls, grep { !/^(#|mailto)/ } @$links );
                $body = $part->body;
            }
        }
    );

    my %unique_urls = map { $_, 1 } @urls;

    for my $url ( sort keys %unique_urls ) {
        my $tx  = $ua->get($url);
        my $err = '';

        if ( $tx->success ) {
            my $res = $tx->result;

            if ( $res->code !~ /^2\d\d/ ) {
                $err = "HTTP code was " . $res->code;
            }
            else {
                my $title = $res->dom->at('title')->text;
                $err = "Page title contains text '$1'"
                  if $title =~ /(error|not found)/i;
            }
        }
        else {
            $err = "Could not retrieve URL: " . $tx->error->{message};
        }
        ok( !$err, "Link in email works ($url)" ) or diag($err);
    }

};

1;
