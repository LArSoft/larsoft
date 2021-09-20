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
        "canvas" => "canvas::canvas",
        "cetlib" => "cetlib::cetlib",
        "cetlib_except" => "cetlib_except::cetlib_except",
        "lardata_Utilities_LArPropertiesServiceArgoNeuT_service" => "ArgoneutUtilities_LArPropertiesServiceArgoNeuT_service",
        "lardata_Utilities_DetectorPropertiesServiceArgoNeuT_service" => "ArgoneutUtilities_DetectorPropertiesServiceArgoNeuT_service",
        "nusimdata_SimulationBase" => "nusimdata::SimulationBase"
                       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&find_ups_product&i;
   next if m&simple_plugin&i;
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
s&\$\{ART_PERSISTENCY_COMMON\}&art::Persistency_Common&;
s&\$\{ART_ROOT_IO\}&art_root_io::art_root_io&;
s&\$\{ART_ROOT_IO_ROOTINPUT_SOURCE\}&art_root_io::RootInput_source&;
s&\$\{ART_ROOT_IO_TFILESERVICE_SERVICE\}&art_root_io::TFileService_service&;
s&\$\{ART_ROOT_IO_TFILE_SUPPORT\}&art_root_io::tfile_support&;
s&\$\{BOOST_DATE_TIME\}&Boost::date_time&;
s&\$\{BOOST_FILESYSTEM\}&Boost::filesystem&;
s&\$\{BOOST_REGEX\}&Boost::regex&;
s&\$\{BOOST_SYSTEM\}&&; # No longer needed
s&\$\{BOOST_THREAD\}&Boost::thread&;
s&\$\{CETLIB\}&cetlib::cetlib&;
s&\$\{CETLIB_EXCEPT\}&cetlib_except::cetlib_except&;
s&\$\{FHICLCPP\}&fhiclcpp::fhiclcpp fhiclcpp::types&;
s&\$\{MF_MESSAGELOGGER\}&messagefacility::MF_MessageLogger&;
s&\$\{MF_UTILITIES\}&&; # No longer exists
s&\$\{ROOT_CORE\}&ROOT::Core&;
s&\$\{ROOT_EG\}&ROOT::EG&;
s&\$\{ROOT_GDML\}&ROOT::Gdml&;
s&\$\{ROOT_GEOM\}&ROOT::Geom&;
s&\$\{ROOT_HIST\}&ROOT::Hist&;
s&\$\{ROOT_MATHMORE\}&ROOT::MathMore&;
s&\$\{ROOT_PHYSICS\}&ROOT::Physics&;
s&\$\{ROOT_RIO\}&ROOT::RIO&;
s&\$\{ROOT_TREE\}&ROOT::Tree&;
s&\$\{ROOT_XMLIO\}&ROOT::XMLIO&;
s&\$\{LIBWDA\}&LIBWDA&;
s&\$\{PQ\}&PQ&;
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
s&\$\{CLHEP\}&CLHEP&;

