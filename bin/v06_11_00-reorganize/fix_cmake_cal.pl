use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
	"larana_Calorimetry_BezierCalorimetry_module" => "larreco_Calorimetry_BezierCalorimetry_module",
	"larana_Calorimetry_Calorimetry_module" => "larreco_Calorimetry_Calorimetry_module",
	"larana_Calorimetry_GeneralCalorimetry_module" => "larreco_Calorimetry_GeneralCalorimetry_module",
	"larana_Calorimetry_PrintCalorimetry_module" => "larreco_Calorimetry_PrintCalorimetry_module",
	"larana_Calorimetry_TrackCalorimetry_module" => "larreco_Calorimetry_TrackCalorimetry_module",
	"larana_OpticalDetector_LEDCalibrationAna_module" => "larreco_OpticalDetector_LEDCalibrationAna_module",
	"larana_Calorimetry" => "larreco_Calorimetry",
	"lardata_AnalysisAlg" => "larreco_Calorimetry",
	"lardata_RecoObjects" => "lardata_RecoObjects larreco_Deprecated",
	"larsim_Simulation" => "larsim_Simulation nutools_ParticleNavigation"
                       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
   next if m&lardata_RecoObjects larreco_Deprecated&i;
   next if m&larsim_Simulation nutools_ParticleNavigation&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}
