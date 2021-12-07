use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
        "art_Persistency_Common" => "art::Persistency_Common",
        "art_Persistency_Provenance" => "art::Persistency_Provenance",
        "art_Framework_Principal" => "art::Framework_Principal",
        "art_Framework_Services_Registry" => "art::Framework_Services_Registry",
        "art_Framework_Services_Optional_RandomNumberGenerator_service" => "art::Framework_Services_Optional_RandomNumberGenerator_service",
        "art_Framework_IO_ProductMix" => "art::Framework_IO_ProductMix",
        "art_Utilities" => "art::Utilities",
        "MF_MessageLogger"  => "messagefacility::MF_MessageLogger",
        "FHICLCPP" => "fhiclcpp::fhiclcpp",
        "canvas" => "canvas::canvas",
        "cetlib" => "cetlib::cetlib",
        "cetlib_except" => "cetlib_except::cetlib_except",
        "IFDH_SERVICE" => "ifdh_art::IFDH_service",
        "SQLITE" => "SQLite::SQLite3",
        "G4EVENT" => "Geant4::G4event",
        "G4DIGITS_HITS" => "Geant4::G4digits_hits",
        "G4GEOMETRY" => "Geant4::G4geometry",
        "G4GLOBAL" => "Geant4::G4global",
        "G4GRAPHICS_REPS" => "Geant4::G4graphics_reps",
        "G4INTERCOMS" => "Geant4::G4intercoms",
        "G4INTERFACES" => "Geant4::G4interfaces",
        "G4MATERIALS" => "Geant4::G4materials",
        "G4MODELING" => "Geant4::G4modeling",
        "G4PARTICLES" => "Geant4::G4particles",
        "G4PERSISTENCY" => "Geant4::G4persistency",
        "G4PHYSICSLISTS" => "Geant4::G4physicslists",
        "G4PROCESSES" => "Geant4::G4processes",
        "G4READOUT" => "Geant4::G4readout",
        "G4RUN" => "Geant4::G4run",
        "G4TRACKING" => "Geant4::G4tracking",
        "G4TRACK" => "Geant4::G4track",
        "G4FR" => "Geant4::G4FR",
        "G4GMOCREN" => "Geant4::G4GMocren",
        "G4RAYTRACER" => "Geant4::G4RayTracer",
        "G4TREE" => "Geant4::G4Tree",
        "G4VRML" => "Geant4::G4VRML",
        "G4VISHEPREP" => "Geant4::G4visHepRep",
        "G4VIS_MANAGEMENT" => "Geant4::G4vis_management",
        "XERCESC" => "XercesC::XercesC",
        "LOG4CPP" => "log4cpp::log4cpp",
        "nusimdata_SimulationBase" => "nusimdata::SimulationBase",
        "nuevdb_EventDisplayBase" => "nuevdb::EventDisplayBase",
        "nuevdb_EventDisplayBase_Colors_service" => "nuevdb::EventDisplayBase_Colors_service",
        "nuevdb_EventDisplayBase_EventDisplay_service" => "nuevdb::EventDisplayBase_EventDisplay_service",
        "nuevdb_EventDisplayBase_ScanOptions_service" => "nuevdb::EventDisplayBase_ScanOptions_service",
        "nuevdb_IFDatabase_DBI_service" => "nuevdb::IFDatabase_DBI_service",
        "nuevdb_IFDatabase" => "nuevdb::IFDatabase",
        "nug4_AdditionalG4Physics" => "nug4::AdditionalG4Physics",
        "nug4_G4Base" => "nug4::G4Base",
        "nug4_MagneticFieldServices_MagneticFieldServiceStandard_service" => "nug4::MagneticFieldServices_MagneticFieldServiceStandard_service",
        "nug4_MagneticField" => "nug4::MagneticField",
        "nug4_ParticleNavigation" => "nug4::ParticleNavigation",
        "nugen_NuReweight" => "nugen::NuReweight",
        "nugen_NuReweight_art" => "nugen::NuReweight_art",
        "nugen_NuReweight_art_ReweightAna_module" => "nugen::NuReweight_art_ReweightAna_module",
        "nugen_EventGeneratorBase_GENIE" => "nugen::EventGeneratorBase_GENIE",
        "nugen_EventGeneratorBase_GiBUU" => "nugen::EventGeneratorBase_GiBUU",
        "nugen_EventGeneratorBase_Modules_AddGenieEventsToArt_module" => "nugen::EventGeneratorBase_Modules_AddGenieEventsToArt_module",
        "nugen_EventGeneratorBase_Modules_GenieOutput_module" => "nugen::EventGeneratorBase_Modules_GenieOutput_module",
        "nugen_EventGeneratorBase_Modules_TestGENIEHelper_module" => "nugen::EventGeneratorBase_Modules_TestGENIEHelper_module",
        "nurandom_RandomUtils_NuRandomService_service" => "nurandom::RandomUtils_NuRandomService_service",
        "nutools_EventGeneratorBase_CRY"  => "nutools::EventGeneratorBase_CRY"
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

s&\$\{ART_FRAMEWORK_CORE\}&art::Framework_Core&;
s&\$\{ART_FRAMEWORK_IO_SOURCES\}&art::Framework_IO_Sources&;
s&\$\{ART_FRAMEWORK_PRINCIPAL\}&art::Framework_Principal&;
s&\$\{ART_FRAMEWORK_SERVICES_REGISTRY\}&art::Framework_Services_Registry&;
s&\$\{ART_FRAMEWORK_SERVICES_OPTIONAL_RANDOMNUMBERGENERATOR_SERVICE\}&art::Framework_Services_Optional_RandomNumberGenerator_service&;
s&\$\{ART_FRAMEWORK_SERVICES_OPTIONAL_TFILESERVICE_SERVICE\}&&;
s&\$\{ART_PERSISTENCY_COMMON\}&art::Persistency_Common&;
s&\$\{ART_PERSISTENCY_PROVENANCE\}&art::Persistency_Provenance&;
s&\$\{ART_UTILITIES\}&art::Utilities&;
s&\$\{ART_ROOT_IO\}&art_root_io::art_root_io&;
s&\$\{ART_ROOT_IO_ROOTDB\}&art_root_io::RootDB&;
s&\$\{ART_ROOT_IO_ROOTINPUT_SOURCE\}&art_root_io::RootInput_source&;
s&\$\{ART_ROOT_IO_TFILESERVICE_SERVICE\}&art_root_io::TFileService_service&;
s&\$\{ART_ROOT_IO_TFILE_SUPPORT\}&art_root_io::tfile_support&;
s&\$\{BOOST_DATE_TIME\}&Boost::date_time&;
s&\$\{Boost_DATE_TIME_LIBRARY\}&Boost::date_time&;
s&\$\{BOOST_FILESYSTEM\}&Boost::filesystem&;
s&\$\{Boost_FILESYSTEM_LIBRARY\}&Boost::filesystem&;
s&\$\{BOOST_REGEX\}&Boost::regex&;
s&\$\{Boost_SERIALIZATION_LIBRARY\}&Boost::serialization&;
s&\$\{BOOST_SYSTEM\}&&; # No longer exists
s&\$\{Boost_SYSTEM_LIBRARY\}&&; # No longer exists
s&\$\{BOOST_THREAD\}&Boost::thread&;
s&\$\{Boost_PROGRAM_OPTIONS_LIBRARY\}&Boost::program_options&;
s&\$\{CANVAS\}&canvas::canvas&;
s&\$\{CETLIB\}&cetlib::cetlib&;
s&\$\{CETLIB_EXCEPT\}&cetlib_except::cetlib_except&;
s&\$\{FHICLCPP\}&fhiclcpp::fhiclcpp&;
s&\$\{fhiclcpp::fhiclcpp\}&fhiclcpp::fhiclcpp&;
s&\$\{MF_MESSAGELOGGER\}&messagefacility::MF_MessageLogger&;
s&\$\{MF_UTILITIES\}&&; # No longer exists
s&\$\{PANDORASDK\}&PANDORASDK&;
s&\$\{PANDORAMONITORING\}&PANDORAMONITORING&;
s&\$\{ROOT_CINT\}&&; # No longer exists
s&\$\{ROOT_CORE\}&ROOT::Core&;
s&\$\{ROOT_EG\}&ROOT::EG&;
s&\$\{ROOT_EVE\}&ROOT::Eve&;
s&\$\{ROOT_FFTW\}&ROOT::FFTW&;
s&\$\{ROOT_GDML\}&ROOT::Gdml&;
s&\$\{ROOT_GED\}&ROOT::Ged&;
s&\$\{ROOT_GEOM\}&ROOT::Geom&;
s&\$\{ROOT_GEOMPAINTER\}&ROOT::GeomPainter&;
s&\$\{ROOT_GPAD\}&ROOT::Gpad&;
s&\$\{ROOT_GRAF\}&ROOT::Graf&;
s&\$\{ROOT_GRAF3D\}&ROOT::Graf3d&;
s&\$\{ROOT_GUI\}&ROOT::Gui&;
s&\$\{ROOT_GX11\}&ROOT::GX11&;
s&\$\{ROOT_HIST\}&ROOT::Hist&;
s&\$\{ROOT_MATHCORE\}&ROOT::MathCore&;
s&\$\{ROOT_MATHMORE\}&ROOT::MathMore&;
s&\$\{ROOT_MATRIX\}&ROOT::Matrix&;
s&\$\{ROOT_NET\}&ROOT::Net&;
s&\$\{ROOT_PHYSICS\}&ROOT::Physics&;
s&\$\{ROOT_POSTSCRIPT\}&ROOT::Postscript&;
s&\$\{ROOT_RGL\}&ROOT::RGL&;
s&\$\{ROOT_RINT\}&ROOT::Rint&;
s&\$\{ROOT_REFLEX\}&&;
s&\$\{ROOT_RIO\}&ROOT::RIO&;
s&\$\{ROOT_THREAD\}&ROOT::Thread&;
s&\$\{ROOT_TREE\}&ROOT::Tree&;
s&\$\{ROOT_TREEPLAYER\}&ROOT::TreePlayer&;
s&\$\{ROOT_XMLIO\}&ROOT::XMLIO&;
s&\$\{ROOT_EGPYTHIA6\}&ROOT::EGPythia6&;
s&\$\{ROOTSYS\}/lib/libEGPythia6.so&ROOT::EGPythia6&;
s&\$\{G4FR\}&G4FR&;
s&\$\{G4GMOCREN\}&G4GMOCREN&;
s&\$\{G4RAYTRACER\}&G4RAYTRACER&;
s&\$\{G4TREE\}&G4TREE&;
s&\$\{G4VRML\}&G4VRML&;
s&\$\{G4EVENT\}&G4EVENT&;
s&\$\{G4GEOMETRY\}&G4GEOMETRY&;
s&\$\{G4GLOBAL\}&G4GLOBAL&;
s&\$\{G4INTERCOMS\}&G4INTERCOMS&;
s&\$\{G4MATERIALS\}&G4MATERIALS&;
s&\$\{G4MODELING\}&G4MODELING&;
s&\$\{G4PARTICLES\}&G4PARTICLES&;
s&\$\{G4PERSISTENCY\}&G4PERSISTENCY&;
s&\$\{G4PHYSICSLISTS\}&G4PHYSICSLISTS&;
s&\$\{G4PROCESSES\}&G4PROCESSES&;
s&\$\{G4READOUT\}&G4READOUT&;
s&\$\{G4RUN\}&G4RUN&;
s&\$\{G4TRACKING\}&G4TRACKING&;
s&\$\{G4VISHEPREP\}&G4VISHEPREP&;
s&\$\{G4VIS_MANAGEMENT\}&G4VIS_MANAGEMENT&;
s&\$\{XERCESC\}&XERCESC&;
s&\$\{LIBWDA\}&LIBWDA&;
s&\$\{PQ\}&PQ&;
s&\$\{CRY\}&CRY&;
s&\$\{CLHEP\}&CLHEP::CLHEP&;
s&\$\{GSL\}&GSL&;
s&\$\{XML2\}&XML2&;
s&\$\{IFDH_SERVICE\}&ifdh_art::IFDH_service&;
s&\$\{IFDH\}&ifdh::ifdh&;
s&\$\{LOG4CPP\}&log4cpp::log4cpp&;
s&\$\{PYTHIA6\}&PYTHIA6&;
s&\$\{LHAPDF\}&LHAPDF&;
s&\$\{SQLITE\}&SQLite::SQLite3&;
s&\$\{SQLITE3\}&SQLite::SQLite3&;
s&\$\{G4FR\}&G4FR&;
s&\$\{G4GMOCREN\}&G4GMOCREN&;
s&\$\{G4RAYTRACER\}&G4RAYTRACER&;
s&\$\{G4TREE\}&G4TREE&;
s&\$\{G4VRML\}&G4VRML&;
s&\$\{G4EVENT\}&G4EVENT&;
s&\$\{G4GEOMETRY\}&G4GEOMETRY&;
s&\$\{G4GLOBAL\}&G4GLOBAL&;
s&\$\{G4GRAPHICS_REPS\}&G4GRAPHICS_REPS&;
s&\$\{G4INTERCOMS\}&G4INTERCOMS&;
s&\$\{G4INTERFACES\}&G4INTERFACES&;
s&\$\{G4MATERIALS\}&G4MATERIALS&;
s&\$\{G4MODELING\}&G4MODELING&;
s&\$\{G4PARTICLES\}&G4PARTICLES&;
s&\$\{G4PERSISTENCY\}&G4PERSISTENCY&;
s&\$\{G4PHYSICSLISTS\}&G4PHYSICSLISTS&;
s&\$\{G4PROCESSES\}&G4PROCESSES&;
s&\$\{G4READOUT\}&G4READOUT&;
s&\$\{G4RUN\}&G4RUN&;
s&\$\{G4TRACK\}&G4TRACK&;
s&\$\{G4VISHEPREP\}&G4VISHEPREP&;
s&\$\{G4VIS_MANAGEMENT\}&G4VIS_MANAGEMENT&;
s&\$\{G4DIGITS_HITS\}&G4DIGITS_HITS&;
s&\$\{XERCESC\}&XERCESC&;
s&\$\{BLAS\}&BLAS&;
s&\$\{DK2NU_TREE\}&DK2NU_TREE&;
s&\$\{DK2NU_GENIE\}&DK2NU_GENIE&;
s&\$\{TENSORFLOW\}&TENSORFLOW&;
s&\$\{PROTOBUF\}&PROTOBUF&;
s&\$\{GRPC_CLIENT\}&TRITON::grpcclient&;
s&\$\{MARLEY\}&MARLEY&;
s&\$\{MARLEY_ROOT\}&MARLEY_ROOT&;
s&\$\{BXDECAY0\}&BXDECAY0&;
s&\$\{JSONCPP\}&JSONCPP&;
