# SYNOPSIS

    use Email::Stuffer::TestLinks;

# NAME

Email::Stuffer::TestLinks - validates links in HTML emails sent by
Email::Stuffer>send\_or\_die()

# DESCRIPTION

When this module is included in a test, it parses http links (&lt;a href="xyz">...&lt;/a>)
and image links (&lt;img src="xyz">) in every email sent through Email::Stuffer->send\_or\_die().
Each URI must be  get a successful response code (200 range).
Page title must not contain 'error' or 'not found' for text/html content.
Image links must return an image content type.
