#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <zip.h>
#include <zipint.h>

typedef HV *Archive__LibZip;

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
