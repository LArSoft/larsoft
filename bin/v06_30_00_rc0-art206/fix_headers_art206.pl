use strict;

use vars qw(%subdir_list);
use vars qw(%header_list);

# explicit headers to avoid conflicts with experiment code
BEGIN { %header_list = (
"cetlib/demangle.h" => "cetlib_except/demangle.h"
		       ); }

foreach my $inc (sort keys %header_list) {
  s&^(\s*#include\s+["<])\Q$inc\E(.*)&${1}$header_list{$inc}${2}& and last;
}
