use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"larrecodnn/ImagePatternAlgs/Tensorflow/WaveformRecogTools/IWaveformRecog.h" => "larrecodnn/ImagePatternAlgs/ToolInterfaces/IWaveformRecog.h",
"larrecodnn/ImagePatternAlgs/Tensorflow/PointIdAlgTools/IPointIdAlg.h" => "larrecodnn/ImagePatternAlgs/ToolInterfaces/IPointIdAlg.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
  s&^(\s*#include\s+["<]GENIE/)\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
