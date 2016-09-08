use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
        "art_Persistency_Common" => "art_Persistency_Common canvas_Persistency_Common",
        "art_Persistency_Provenance" => "art_Persistency_Provenance canvas_Persistency_Provenance",
        "art_Persistency_Common_dict" => "canvas_Persistency_Common_dict",
        "art_Persistency_StdDictionaries" => "canvas_Persistency_StdDictionaries",
        "art_Persistency_StdDictionaries_dict" => "canvas_Persistency_StdDictionaries_dict",
        "art_Persistency_WrappedStdDictionaries" => "canvas_Persistency_WrappedStdDictionaries",
        "art_Persistency_WrappedStdDictionaries_dict" => "canvas_Persistency_WrappedStdDictionaries_dict",
        "art_Utilities" => "art_Utilities canvas_Utilities",
	"Colors_service" => "nutools_EventDisplayBase_Colors_service",
	"DBI_service" => "nutools_IFDatabase_DBI_service",
	"EventDisplayBase" => "nutools_EventDisplayBase",
	"EventDisplay_service" => "nutools_EventDisplayBase_EventDisplay_service",
	"EventGeneratorBaseCRY" => "nutools_EventGeneratorBase_CRY",
	"EventGeneratorBaseGENIE" => "nutools_EventGeneratorBase_GENIE",
	"EventGeneratorBaseGiBUU" => "nutools_EventGeneratorBase_GiBUU",
	"EventGeneratorBase_test_EventGeneratorTest_module" => "nutools_EventGeneratorBase_test_EventGeneratorTest_module",
	"G4Base" => "nutools_G4Base",
	"IFDatabase" => "nutools_IFDatabase",
	"MagneticField_service" => "nutools_MagneticField_MagneticField_service",
	"NuBeamWeights" => "nutools_NuBeamWeights",
	"NuReweightArt" => "nutools_NuReweight_art",
	"NuReweight" => "nutools_NuReweight",
	"ReweightAna_module" => "nutools_NuReweight_art_ReweightAna_module",
	"ScanOptions_service" => "nutools_EventDisplayBase_ScanOptions_service",
	"SimulationBase_dict" => "nutools_SimulationBase_dict",
	"SimulationBase" => "nusimdata_SimulationBase",
	"larcore_SummaryData" => "larcoreobj_SummaryData",
	"lardata_AnalysisBase_dict" => "lardataobj_AnalysisBase_dict",
	"lardata_AnalysisBase" => "lardataobj_AnalysisBase",
	"lardata_MCBase_dict" => "lardataobj_MCBase_dict",
	"lardata_MCBase" => "lardataobj_MCBase",
	"lardata_OpticalDetectorData_dict" => "lardataobj_OpticalDetectorData_dict",
	"lardata_OpticalDetectorData" => "lardataobj_OpticalDetectorData",
	"lardata_RawData_dict" => "lardataobj_RawData_dict",
	"lardata_RawData" => "lardataobj_RawData",
	"lardata_RecoBase_dict" => "lardataobj_RecoBase_dict",
	"lardata_RecoBase" => "lardataobj_RecoBase",
	"larsim_Simulation_dict" => "larsimobj_Simulation_dict",
	"larsim_Simulation" => "larsim_Simulation larsimobj_Simulation"
                       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&art_Persistency_Common canvas_Persistency_Common&i;
   next if m&art_Persistency_Provenance canvas_Persistency_Provenance&i;
   next if m&art_Utilities canvas_Utilities&i;
   next if m&larsim_Simulation larsimobj_Simulation&i;
   next if m&larsim_Simulation lardataobj_Simulation&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}

s%\$ENV\{ART_DIR\}/Modules%\$ENV\{CANVAS_DIR\}/Modules%g;
s/\$\{ART_PERSISTENCY_COMMON\}/art_Persistency_Common canvas_Persistency_Common/g;
s/\$\{ART_PERSISTENCY_PROVENANCE\}/art_Persistency_Provenance canvas_Persistency_Provenance/g;
s/\$\{ART_UTILITIES\}/art_Utilities canvas_Utilities/g;
s/\$\{SIMULATIONBASE\}/nusimdata_SimulationBase/g;
s/\$\{G4BASE\}/nutools_G4Base/g;
s/\$\{EVENTGENERATORBASECRY\}/nutools_EventGeneratorBase_CRY/g;
s/\$\{EVENTGENERATORBASEGENIE\}/nutools_EventGeneratorBase_GENIE/g;
s/\$\{EVENTGENERATORBASEGIBUU\}/nutools_EventGeneratorBase_GiBUU/g;
s/\$\{EVENTDISPLAYBASE\}/nutools_EventDisplayBase/g;
s/\$\{IFDATABASE\}/nutools_IFDatabase/g;
s/\$\{NUREWEIGHT\}/nutools_NuReweight/g;
s/\$\{MAGNETICFIELD_SERVICE\}/nutools_MagneticField_MagneticField_service/g;
s/larsimobj_Simulation/lardataobj_Simulation/g;
