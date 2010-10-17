use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok( 'Archive::LibZip', ':constants' ) }

my $lz = Archive::LibZip->new();
isa_ok( $lz, 'Archive::LibZip' );

my $status;

my $file = 'files/sample.zip';
$status = $lz->open($file);
is( $status, ZIP_ER_OK, 'file opened successfully' );

is ( $lz->find('a/b'), 1, 'file matched' );
is (
    $lz->find( 'B', ZIP_FL_NOCASE | ZIP_FL_NODIR ),
    1, 'file matched (case insensitive, no directory)'
);
