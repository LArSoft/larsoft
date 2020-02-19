use strict;

use vars qw(%dir_list);

BEGIN { %dir_list = (
"larsim_LArG4" => "larsim_LegacyLArG4",
"larsim_LArG4_LArG4Ana_module"  => "larsim_LegacyLArG4_LArG4Ana_module",
"larsim_LArG4_LArG4_module"  => "larsim_LegacyLArG4_LArG4_module",
"larsim_LArG4_LArSimChannelAna_module"  => "larsim_LegacyLArG4_LArSimChannelAna_module"
		       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}
