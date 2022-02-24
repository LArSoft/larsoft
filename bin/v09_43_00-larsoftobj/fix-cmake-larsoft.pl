
use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
        "larcoreobj_SimpleTypesAndConstants" => "larcoreobj::SimpleTypesAndConstants",
        "larcoreobj_SummaryData"  => "larcoreobj::SummaryData",
        "larcorealg_CoreUtils"  => "larcorealg::CoreUtils",
        "larcorealg_GeoAlgo"  => "larcorealg::GeoAlgo",
        "larcorealg_Geometry"  => "larcorealg::Geometry",
        "larcorealg_GeometryTestLib"  => "larcorealg::GeometryTestLib",
        "larcorealg_TestUtils"  => "larcorealg::TestUtils",
        "lardataobj_AnalysisBase"  => "lardataobj::AnalysisBase",
        "lardataobj_MCBase"  => "lardataobj::MCBase",
        "lardataobj_OpticalDetectorData"  => "lardataobj::OpticalDetectorData",
        "lardataobj_RawData"  => "lardataobj::RawData",
        "lardataobj_RecoBase"  => "lardataobj::RecoBase",
        "lardataobj_Simulation"  => "lardataobj::Simulation",
        "lardataalg_DetectorInfo"  => "lardataalg::DetectorInfo",
        "lardataalg_MCDumpers"  => "lardataalg::MCDumpers",
        "larvecutils_MarqFitAlg"  => "larvecutils::MarqFitAlg"
                       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&find_ups_product&i;
   next if m&cet_find_library&i;
   next if m&simple_plugin&i;
   next if m&create_version_variables&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
   next if m&LIBRARY_NAME&i;
   next if m&PACKAGE&i;
   next if m&fhiclcpp::fhiclcpp&i;
   next if m&canvas::canvas&i;
   next if m&cetlib::cetlib&i;
   next if m&cetlib_except::cetlib_except&i;
   next if m&messagefacility::MF&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}

