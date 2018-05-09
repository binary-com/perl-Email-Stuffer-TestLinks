# NAME

Email::Stuffer::TestLinks - validates links in HTML emails sent by Email::Stuffer>send_or_die()

# VERSION

version 0.010

# SYNOPSIS

    use Email::Stuffer::TestLinks;

# DESCRIPTION

When this module is included in a test, it parse HTML links in every email sent through check Email::Stuffer.
Only html links (<a href="xyz"...) are checked. Each link must be valid resource and the returned page title must not contain 'error' or 'not found'.