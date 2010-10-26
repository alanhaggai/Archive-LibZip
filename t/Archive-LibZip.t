use strict;
use warnings;

use Test::More tests => 13;

BEGIN { use_ok( 'Archive::LibZip', ':constants' ) }

my $lz = Archive::LibZip->new();
isa_ok( $lz, 'Archive::LibZip' );

my $file = 'files/sample.zip';
my $status = $lz->open($file);
is( $status, ZIP_ER_OK, 'file opened successfully' );

is( $lz->find('a/b'), 1, 'file matched' );
is(
    $lz->find( 'B', ZIP_FL_NOCASE | ZIP_FL_NODIR ),
    1, 'file matched (case insensitive, no directory)'
);

my $lz_file = $lz->fopen('a/b');
is( $lz->error('zip'), ZIP_ER_OK, 'no errors' );
isa_ok( $lz_file, 'Archive::LibZip::File' );
my $text;
( $text, $status ) = $lz_file->fread();
is( $status, 14, 'status OK' );
is( $text,  "Hello, world!\n", 'fread() without argument' );
is( $lz_file->fclose(), ZIP_ER_OK, 'close file' );

$lz_file = $lz->fopen('a/b');
( $text, $status ) = $lz_file->fread(5);
is( $status, 5, 'status OK' );
is( $text,  'Hello', 'fread() with argument' );
$lz_file->fclose();

is_deeply(
    $lz->stat('a/b'),
    {
        'mtime'             => 1287053122,
        'compressed_method' => 49894,
        'crc'               => 2069210904,
        'name'              => 'a/b',
        'compressed_size'   => 0,
        'size'              => 14,
        'index'             => 1,
        'encryption_method' => 2064,
    },
    'stat'
);
