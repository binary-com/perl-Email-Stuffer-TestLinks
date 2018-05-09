# NAME

Email::Stuffer::TestLinks - validates links in HTML emails sent by Email::Stuffer>send_or_die()

# VERSION

version 0.010

# SYNOPSIS

    use Email::Stuffer::TestLinks;

# DESCRIPTION

When this module is included in a test, it parses HTML links (<a href="xyz"...) in every email sent through 
Email::Stuffer->send_or_die(). Each URI must a successful response code and the returned page title must not 
contain 'error' or 'not found'.