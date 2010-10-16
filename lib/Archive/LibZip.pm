package Archive::LibZip;

use 5.012002;

use strict;
use warnings;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load( 'Archive::LibZip', $VERSION );

1;


__END__

=head1 NAME

Archive::LibZip - Perl extension to provide an interface to the libzip C library

=head1 AUTHOR

Alan Haggai Alavi <alanhaggai@alanhaggai.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Alan Haggai Alavi.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
