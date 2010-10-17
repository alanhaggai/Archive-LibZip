#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <zip.h>
#include <zipint.h>

typedef HV *Archive__LibZip;

struct zip *
_get_archive_struct( Archive__LibZip lz ) {
    SV **archive_ptr = hv_fetch( lz, "archive", 7, 0 );
    return ( struct zip * ) SvIV( *archive_ptr );
}

MODULE = Archive::LibZip    PACKAGE = Archive::LibZip

PROTOTYPES: ENABLE

int
open( lz, path, flag = 0 )
        Archive::LibZip  lz
        const char      *path
        int              flag

    CODE:
        int         error = ZIP_ER_OK;
        struct zip *archive;

        archive = zip_open( path, flag, &error );
        hv_store( lz, "archive", 7, newSVuv( ( unsigned int ) archive ), 0 );

        RETVAL = error;

    OUTPUT:
        RETVAL

int
find( lz, filename, flag = 0 )
        Archive::LibZip  lz
        const char      *filename
        int              flag

    CODE:
        struct zip *archive = _get_archive_struct(lz);

        RETVAL = zip_name_locate( archive, filename, flag );

    OUTPUT:
        RETVAL
