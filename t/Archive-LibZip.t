use strict;
use warnings;

use Test::More tests => 11;
BEGIN { use_ok( 'Archive::LibZip', ':constants' ) }

my $lz = Archive::LibZip->new();
isa_ok( $lz, 'Archive::LibZip' );

my $status;

my $file = 'files/sample.zip';
$status = $lz->open($file);
is( $status, ZIP_ER_OK, 'file opened successfully' );

is( $lz->find('a/b'), 1, 'file matched' );
is(
    $lz->find( 'B', ZIP_FL_NOCASE | ZIP_FL_NODIR ),
    1, 'file matched (case insensitive, no directory)'
);

my $lz_file = $lz->fopen('a/b');
is( $lz->error('zip'), ZIP_ER_OK, 'no errors' );
isa_ok( $lz_file, 'Archive::LibZip::File' );
my ( $text, $status ) = $lz_file->fread();
is( $status, 14, 'status OK' );
is( $text,  "Hello, world!\n", 'fread() without argument' );

$lz_file = $lz->fopen('a/b');
( $text, $status ) = $lz_file->fread(5);
is( $status, 5, 'status OK' );
is( $text,  'Hello', 'fread() with argument' );
