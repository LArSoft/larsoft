use strict;

use vars qw(%dir_list);

BEGIN { %dir_list = (
"larrecodnn_ImagePatternAlgs_Tensorflow_WaveformRecogTools_WaveformRecogTf_tool" => "larrecodnn_ImagePatternAlgs_Tensorflow_Tools_WaveformRecogTf_tool",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_PointIdTrainingData_module" => "larrecodnn_ImagePatternAlgs_Modules_PointIdTrainingData_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_WaveformRecogTools_WaveformRecogTrtis_tool" => "larrecodnn_ImagePatternAlgs_Triton_Tools_WaveformRecogTrtis_tool",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_ParticleDecayId_module" => "larrecodnn_ImagePatternAlgs_Modules_ParticleDecayId_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_PointIdAlgTools_PointIdAlgTrtis_tool" => "larrecodnn_ImagePatternAlgs_Triton_Tools_PointIdAlgTrtis_tool",
"larrecodnn_ImagePatternAlgs_Tensorflow_PointIdAlgTools_PointIdAlgTf_tool" => "larrecodnn_ImagePatternAlgs_Tensorflow_Tools_PointIdAlgTf_tool",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EvaluateROIEff_module" => "larrecodnn_ImagePatternAlgs_Modules_EvaluateROIEff_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId3out_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackClusterId3out_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackMichelIdTl_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackMichelIdTl_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackMichelId_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackMichelId_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId2outTl_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackClusterId2outTl_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId2out_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackClusterId2out_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_EmTrackClusterId3outTl_module" => "larrecodnn_ImagePatternAlgs_Modules_EmTrackClusterId3outTl_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_PointIdAlgTools_PointIdAlgKeras_tool" => "larrecodnn_ImagePatternAlgs_Keras_Tools_PointIdAlgKeras_tool",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_PointIdEffTest_module" => "larrecodnn_ImagePatternAlgs_Modules_PointIdEffTest_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_CheckCNNScore_module" => "larrecodnn_ImagePatternAlgs_Modules_CheckCNNScore_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_WaveformRoiFinder_module" => "larrecodnn_ImagePatternAlgs_Modules_WaveformRoiFinder_module",
"larrecodnn_ImagePatternAlgs_Tensorflow_Modules_RawWaveformDump_module" => "larrecodnn_ImagePatternAlgs_Modules_RawWaveformDump_module"
		       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}

