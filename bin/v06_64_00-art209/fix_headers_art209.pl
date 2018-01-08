use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"art/Persistency/RootDB/SQLite3Wrapper.h" => "art/Framework/IO/Root/RootDB/SQLite3Wrapper.h",
"art/Persistency/RootDB/SQLErrMsg.h"      => "art/Framework/IO/Root/RootDB/SQLErrMsg.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
