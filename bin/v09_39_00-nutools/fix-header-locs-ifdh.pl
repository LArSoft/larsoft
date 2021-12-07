use strict;

use vars qw(%inc_translations $g4physics_list);
BEGIN { %inc_translations = (
		"IFDH_service.h" => "ifdh_art/IFDHService/IFDH_service.h",
		"IFBeam_service.h" => "ifdh_art/IFBeamService/IFBeam_service.h",
		"IFCatalogInterface_service.h" => "ifdh_art/IFCatalogInterface/IFCatalogInterface_service.h",
		"IFFileTransfer_service.h" => "ifdh_art/IFFileTransfer/IFFileTransfer_service.h",
		"nucondb_service.h" => "ifdh_art/NUconDBService/NUconDB_service.h"
                            );

      }

foreach my $inc (sort keys %inc_translations) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$inc_translations{$inc}${2}& and last;
}



### Local Variables:
### mode: cperl
### End:
