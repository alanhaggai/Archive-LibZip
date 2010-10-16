use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok( 'Archive::LibZip', ':constants' ) }

my $lz = Archive::LibZip->new();
isa_ok( $lz, 'Archive::LibZip' );

my $status;

my $file = 'files/sample.zip';
$status = $lz->open($file);
is ( $status, ZIP_ER_OK, 'file opened successfully' );
