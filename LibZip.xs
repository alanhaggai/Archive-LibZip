#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <zip.h>
#include "zipint.h"

typedef HV *Archive__LibZip;

struct zip *
_get_archive_struct(Archive__LibZip lz) {
    SV **archive_ptr = hv_fetch(lz, "archive", 7, 0);
    return (struct zip *)(unsigned int)SvIV(*archive_ptr);
}

MODULE = Archive::LibZip    PACKAGE = Archive::LibZip

PROTOTYPES: ENABLE

int
open(lz, path, flag = 0)
        Archive::LibZip  lz
        const char      *path
        int              flag

    CODE:
        int         error = ZIP_ER_OK;
        struct zip *archive;

        archive = zip_open(path, flag, &error);
        hv_store(lz, "archive", 7, newSVuv((unsigned int)archive), 0);

        RETVAL = error;

    OUTPUT:
        RETVAL

int
find(lz, filename, flag = 0)
        Archive::LibZip  lz
        const char      *filename
        int              flag

    CODE:
        struct zip *archive = _get_archive_struct(lz);

        RETVAL = zip_name_locate(archive, filename, flag);

    OUTPUT:
        RETVAL

void
fopen(lz, filename, flag = 0)
        Archive::LibZip  lz
        const char      *filename
        int              flag

    PPCODE:
        struct zip      *archive;
        struct zip_file *file;

        archive = _get_archive_struct(lz);
        file    = zip_fopen(archive, filename, flag);

        if (file != NULL) {
            HV *hash = (HV *)sv_2mortal((SV *)newHV());
            hv_store(hash, "file", 4, newSVuv((unsigned int)file), 0);

            SV *lz_file = sv_bless(newRV((SV *)hash),
                                   gv_stashpv("Archive::LibZip::File", 1));

            XPUSHs(sv_2mortal(lz_file));
        }
        else {
            XPUSHs(&PL_sv_undef);
        }

SV *
error(lz, option)
        Archive::LibZip  lz
        char            *option

    CODE:
        struct zip *archive;
        SV         *zip_error;

        archive = _get_archive_struct(lz);
        if (strcmp(option, "zip") == 0) {
            zip_error = newSViv(archive->error.zip_err);
        }
        else if (strcmp(option, "sys") == 0) {
            zip_error = newSViv(archive->error.sys_err);
        }
        else if (strcmp(option, "str") == 0) {
            zip_error = newSVpv(archive->error.str, strlen(archive->error.str));
        }

        RETVAL = zip_error;

    OUTPUT:
        RETVAL
