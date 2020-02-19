use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"larsim/LArG4/AuxDetReadout.h" => "larsim/LegacyLArG4/AuxDetReadout.h",
"larsim/LArG4/AuxDetReadoutGeometry.h" => "larsim/LegacyLArG4/AuxDetReadoutGeometry.h",
"larsim/LArG4/ConfigurablePhysicsList.hh" => "larsim/LegacyLArG4/ConfigurablePhysicsList.hh",
"larsim/LArG4/ConfigurablePhysicsList.icc" => "larsim/LegacyLArG4/ConfigurablePhysicsList.icc",
"larsim/LArG4/CustomPhysicsBuiltIns.hh" => "larsim/LegacyLArG4/CustomPhysicsBuiltIns.hh",
"larsim/LArG4/CustomPhysicsFactory.hh" => "larsim/LegacyLArG4/CustomPhysicsFactory.hh",
"larsim/LArG4/CustomPhysicsTable.hh" => "larsim/LegacyLArG4/CustomPhysicsTable.hh",
"larsim/LArG4/FastOpticalPhysics.h" => "larsim/LegacyLArG4/FastOpticalPhysics.h",
"larsim/LArG4/G4BadIdeaAction.h" => "larsim/LegacyLArG4/G4BadIdeaAction.h",
"larsim/LArG4/G4ThermalElectron.hh" => "larsim/LegacyLArG4/G4ThermalElectron.hh",
"larsim/LArG4/ISCalculation.h" => "larsim/LegacyLArG4/ISCalculation.h",
"larsim/LArG4/ISCalculationNEST.h" => "larsim/LegacyLArG4/ISCalculationNEST.h",
"larsim/LArG4/ISCalculationSeparate.h" => "larsim/LegacyLArG4/ISCalculationSeparate.h",
"larsim/LArG4/IonizationAndScintillation.h" => "larsim/LegacyLArG4/IonizationAndScintillation.h",
"larsim/LArG4/IonizationAndScintillationAction.h" => "larsim/LegacyLArG4/IonizationAndScintillationAction.h",
"larsim/LArG4/LArStackingAction.h" => "larsim/LegacyLArG4/LArStackingAction.h",
"larsim/LArG4/LArVoxelReadout.h" => "larsim/LegacyLArG4/LArVoxelReadout.h",
"larsim/LArG4/LArVoxelReadoutGeometry.h" => "larsim/LegacyLArG4/LArVoxelReadoutGeometry.h",
"larsim/LArG4/MaterialPropertyLoader.h" => "larsim/LegacyLArG4/MaterialPropertyLoader.h",
"larsim/LArG4/MuNuclearSplittingProcess.h" => "larsim/LegacyLArG4/MuNuclearSplittingProcess.h",
"larsim/LArG4/MuNuclearSplittingProcessXSecBias.h" => "larsim/LegacyLArG4/MuNuclearSplittingProcessXSecBias.h",
"larsim/LArG4/NestAlg.h" => "larsim/LegacyLArG4/NestAlg.h",
"larsim/LArG4/NeutronHPphysics.hh" => "larsim/LegacyLArG4/NeutronHPphysics.hh",
"larsim/LArG4/OpBoundaryProcessSimple.hh" => "larsim/LegacyLArG4/OpBoundaryProcessSimple.hh",
"larsim/LArG4/OpDetLookup.h" => "larsim/LegacyLArG4/OpDetLookup.h",
"larsim/LArG4/OpDetPhotonTable.h" => "larsim/LegacyLArG4/OpDetPhotonTable.h",
"larsim/LArG4/OpDetReadoutGeometry.h" => "larsim/LegacyLArG4/OpDetReadoutGeometry.h",
"larsim/LArG4/OpDetSensitiveDetector.h" => "larsim/LegacyLArG4/OpDetSensitiveDetector.h",
"larsim/LArG4/OpFastScintillation.hh" => "larsim/LegacyLArG4/OpFastScintillation.hh",
"larsim/LArG4/OpParamAction.h" => "larsim/LegacyLArG4/OpParamAction.h",
"larsim/LArG4/OpParamSD.h" => "larsim/LegacyLArG4/OpParamSD.h",
"larsim/LArG4/OpticalPhysics.hh" => "larsim/LegacyLArG4/OpticalPhysics.hh",
"larsim/LArG4/ParticleListAction.h" => "larsim/LegacyLArG4/ParticleListAction.h",
"larsim/LArG4/PhysicsList.h" => "larsim/LegacyLArG4/PhysicsList.h",
"larsim/LArG4/VisualizationAction.h" => "larsim/LegacyLArG4/VisualizationAction.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
  s&^(\s*#include\s+["<]GENIE/)\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
