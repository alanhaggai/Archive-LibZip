package Archive::LibZip;

use 5.012002;

use strict;
use warnings;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load( 'Archive::LibZip', $VERSION );

use base 'Exporter';

our @EXPORT_OK = qw{
    ZIP_ER_OK
};
our %EXPORT_TAGS = ( 'constants' => \@EXPORT_OK );

use constant {
    ZIP_ER_OK     => 0,
    ZIP_ER_EXISTS => 10,
    ZIP_ER_INCONS => 21,
    ZIP_ER_INVAL  => 18,
    ZIP_ER_MEMORY => 14,
    ZIP_ER_NOENT  => 9,
    ZIP_ER_NOZIP  => 19,
    ZIP_ER_OPEN   => 11,
    ZIP_ER_SEEK   => 4,
    ZIP_ER_READ   => 5,
};

sub new {
    my $package = shift;
    return bless {}, $package;
}

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
