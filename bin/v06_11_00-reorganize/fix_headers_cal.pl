use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"lardata/AnalysisAlg/CalorimetryAlg.h" => "larreco/Calorimetry/CalorimetryAlg.h",
"lardata/AnalysisAlg/Chi2PIDAlg.h" => "larana/ParticleIdentification/Chi2PIDAlg.h",
"lardata/RecoObjects/BezierCurveHelper.h" => "larreco/Deprecated/BezierCurveHelper.h",
"lardata/RecoObjects/BezierTrack.h" => "larreco/Deprecated/BezierTrack.h",
"larana/Calorimetry/TrackCalorimetryAlg.h" => "larreco/Calorimetry/TrackCalorimetryAlg.h",
"larsim/Simulation/EmEveIdCalculator.h" => "nutools/ParticleNavigation/EmEveIdCalculator.h",
"larsim/Simulation/EveIdCalculator.h" => "nutools/ParticleNavigation/EveIdCalculator.h",
"larsim/Simulation/ParticleHistory.h" => "nutools/ParticleNavigation/ParticleHistory.h",
"larsim/Simulation/ParticleList.h" => "nutools/ParticleNavigation/ParticleList.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
