use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
                        "gaus" => "gaus(0)"
		       ); }

foreach my $lib (sort keys %dir_list) {
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}
