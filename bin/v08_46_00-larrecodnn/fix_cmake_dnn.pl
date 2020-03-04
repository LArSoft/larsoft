use strict;

use vars qw(%dir_list);

BEGIN { %dir_list = (
"larreco_RecoAlg_ImagePatternAlgs_Keras" => "larrecodnn_ImagePatternAlgs_Keras",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_CheckCNNScore_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_CheckCNNScore_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId2out_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId2out_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId3out_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId3out_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_EmTrackMichelId_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackMichelId_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_ParticleDecayId_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_ParticleDecayId_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_PointIdEffTest_module" => "larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_PointIdEffTest_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_Modules_PointIdTrainingData_module" => "larrecodnn_ImagePatternAlgs_Tensorflow_Modules_PointIdTrainingData_module",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_PointIdAlg" => "larrecodnn_ImagePatternAlgs_Tensorflow_PointIdAlg",
"larreco_RecoAlg_ImagePatternAlgs_Tensorflow_TF" => "larrecodnn_ImagePatternAlgs_Tensorflow_TF"
		       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}
