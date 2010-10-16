use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Archive::LibZip') }

my $lz = Archive::LibZip->new();
isa_ok( $lz, 'Archive::LibZip' );
