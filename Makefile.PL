use 5.012002;

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'           => 'Archive::LibZip',
    'VERSION_FROM'   => 'lib/Archive/LibZip.pm',
    'BUILD_REQUIRES' => {
        'ExtUtils::MakeMaker' => '6.31',
        'Test::More'          => '0'
    },
    'PREREQ_PM' => {},
    (
        $] >= 5.005
        ? (
            'ABSTRACT_FROM' => 'lib/Archive/LibZip.pm',
            'AUTHOR'        => 'Alan Haggai Alavi <alanhaggai@alanhaggai.org>'
          )
        : ()
    ),
    'LIBS'   => ['-lzip'],
    'DEFINE' => '',
    'INC'    => '-I.',
);
