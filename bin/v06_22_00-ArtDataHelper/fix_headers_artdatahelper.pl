use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"lardata/RecoBaseArt/Dumpers/DumpAssociations.h" => "lardata/ArtDataHelper/Dumpers/DumpAssociations.h",
"lardata/RecoBaseArt/Dumpers/NewLine.h" => "lardata/ArtDataHelper/Dumpers/NewLine.h",
"lardata/RecoBaseArt/Dumpers/PCAxisDumpers.h" => "lardata/ArtDataHelper/Dumpers/PCAxisDumpers.h",
"lardata/RecoBaseArt/Dumpers/SpacePointDumpers.h" => "lardata/ArtDataHelper/Dumpers/SpacePointDumpers.h",
"lardata/RecoBaseArt/Dumpers/hexfloat.h" => "lardata/ArtDataHelper/Dumpers/hexfloat.h",
"lardata/RecoBaseArt/FindAllP.h" => "lardata/ArtDataHelper/FindAllP.h",
"lardata/RecoBaseArt/HitCreator.h" => "lardata/ArtDataHelper/HitCreator.h",
"lardata/RecoBaseArt/HitUtils.h" => "lardata/ArtDataHelper/HitUtils.h",
"lardata/RecoBaseArt/TrackUtils.h" => "lardata/ArtDataHelper/TrackUtils.h",
"lardata/RecoBaseArt/WireCreator.h" => "lardata/ArtDataHelper/WireCreator.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
