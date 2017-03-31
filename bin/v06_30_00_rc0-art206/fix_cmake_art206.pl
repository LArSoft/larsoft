use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
	"canvas_Utilities" => "canvas",
	"canvas_Persistency_Common" => "canvas",
	"canvas_Persistency_Provenance" => "canvas",
        "cetlib" => "cetlib cetlib_except"
                       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
   next if m&cetlib cetlib_except&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}

s/\$\{CETLIB\}/cetlib cetlib_except/g;

