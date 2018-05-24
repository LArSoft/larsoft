use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"lardata/DetectorInfo/ClockConstants.h" => "lardataalg/DetectorInfo/ClockConstants.h",
"lardata/DetectorInfo/DetectorClocksException.h" => "lardataalg/DetectorInfo/DetectorClocksException.h",
"lardata/DetectorInfo/DetectorClocks.h" => "lardataalg/DetectorInfo/DetectorClocks.h",
"lardata/DetectorInfo/DetectorClocksStandard.h" => "lardataalg/DetectorInfo/DetectorClocksStandard.h",
"lardata/DetectorInfo/DetectorClocksStandardTestHelpers.h" => "lardataalg/DetectorInfo/DetectorClocksStandardTestHelpers.h",
"lardata/DetectorInfo/DetectorClocksStandardTriggerLoader.h" => "lardataalg/DetectorInfo/DetectorClocksStandardTriggerLoader.h",
"lardata/DetectorInfo/DetectorProperties.h" => "lardataalg/DetectorInfo/DetectorProperties.h",
"lardata/DetectorInfo/DetectorPropertiesStandard.h" => "lardataalg/DetectorInfo/DetectorPropertiesStandard.h",
"lardata/DetectorInfo/DetectorPropertiesStandardTestHelpers.h" => "lardataalg/DetectorInfo/DetectorPropertiesStandardTestHelpers.h",
"lardata/DetectorInfo/ElecClock.h" => "lardataalg/DetectorInfo/ElecClock.h",
"lardata/DetectorInfo/LArProperties.h" => "lardataalg/DetectorInfo/LArProperties.h",
"lardata/DetectorInfo/LArPropertiesStandard.h" => "lardataalg/DetectorInfo/LArPropertiesStandard.h",
"lardata/DetectorInfo/LArPropertiesStandardTestHelpers.h" => "lardataalg/DetectorInfo/LArPropertiesStandardTestHelpers.h",
"lardata/DetectorInfo/RunHistory.h" => "lardataalg/DetectorInfo/RunHistory.h",
"lardata/DetectorInfo/RunHistoryStandard.h" => "lardataalg/DetectorInfo/RunHistoryStandard.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
