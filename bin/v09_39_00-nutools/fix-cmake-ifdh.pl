use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
        "IFBEAM" => "ifbeam::ifbeam",
        "WDA" => "wda::wda",
        "IFDH" => "ifdh::ifdh",
        "NUCONDB" => "nucondb::nucondb"
		       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&find_ups_product&i;
   next if m&cet_find_library&i;
   next if m&simple_plugin&i;
   next if m&create_version_variables&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
   next if m&LIBRARY_NAME&i;
   next if m&PACKAGE&i;
   next if m&ifdh::ifdh&i;
   next if m&wda::wda&i;
   next if m&ifbeam::ifbeam&i;
   next if m&nucondb::nucondb&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}


s&\$\{IFDH\}&ifdh::ifdh&;
s&\$\{ifdh::ifdh\}&ifdh::ifdh&;
s&\$\{IFBEAM\}&ifbeam::ifbeam&;
s&\$\{ifbeam::ifbeam\}&ifbeam::ifbeam&;
s&\$\{WDA\}&wda::wda&;
s&\$\{wda::wda\}&wda::wda&;
s&\$\{NUCONDB\}&nucondb::nucondb&;
s&\$\{nucondb::nucondb\}&nucondb::nucondb&;

