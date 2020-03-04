use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"larreco/RecoAlg/ImagePatternAlgs/Keras/keras_model.h" => "larrecodnn/ImagePatternAlgs/Keras/keras_model.h",
"larreco/RecoAlg/ImagePatternAlgs/Tensorflow/PointIdAlg/PointIdAlg.h" => "larrecodnn/ImagePatternAlgs/Tensorflow/PointIdAlg/PointIdAlg.h",
"larreco/RecoAlg/ImagePatternAlgs/Tensorflow/TF/tf_graph.h" => "larrecodnn/ImagePatternAlgs/Tensorflow/TF/tf_graph.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
  s&^(\s*#include\s+["<]GENIE/)\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
