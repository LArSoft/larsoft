use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"larpandora/LArPandoraObjects/PFParticleMetadata.h" => "lardataobj/RecoBase/PFParticleMetadata.h"
"larsim/LArG4/ParticleFilters.h" => "larcorealg/CoreUtils/ParticleFilters.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
