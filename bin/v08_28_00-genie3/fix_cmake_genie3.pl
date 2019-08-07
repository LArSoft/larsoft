use strict;

use vars qw(%dir_list);

BEGIN { %dir_list = (
"GALGORITHM" => "GFWALG",
"GHEP" => "GFWGHEP",
"GEVGCORE" => "GFWEG",
"GPDG" => "GFWPARDAT",
"GMESSENGER" => "GFWMSG",
"GNUCLEONDECAY" => "GPHNDCY",
"GMUELOSS" => "GPHMEL",
"GFLUXDRIVERS" => "GTLFLX",
"GGEO" => "GTLGEO",
"GUTILS" => "GFWUTL",
"GREGISTRY" => "GFWREG",
"GRES" => "GPHRESEG GPHRESXS",
"GQEL" => "GPHQELEG",
"GPDF" => "GPHPDF",
"GPDG" => "GFWPARDAT",
"GQPM" => "PHDISXS",
"GNUMERICAL" => "GFWNUM",
"GNUCLEAR" => "GPHNUCLST",
"GNTUPLE" => "GFWNTP",
"GNUE" => "GPHNUELEG GPHNUELXS",
"GNUGAMMA" => "GPHAMNGEG GPHAMNGXS",
"GMEC" => "GPHMNUCEG GPHMNUCXS",
"GINTERACTION" => "GFWINT",
"GFRAGMENTATION" => "GPHHADNZ",
"GHADRONTRANSP" => "GPHHADTRANSP",
"GDECAY" => "GPHDCY",
"GCROSSSECTIONS" => "GPHXSIG",
"GDIS" => "GPHDISEG",
"GDFRC" => "GPHDFRCEG",
"GREINSEHGAL" => "GPHRESXS",
"GLLEWELLYNSMITH" => "GPHQELXS",
"GREWEIGHT" => "GTLREW",
"GEVGMODULES" => "GPHCMN",
"GEVGDRIVERS" => "GFWEG",
"GGIBUU" => "GPHRESXS",
"GELAS" => "GPHQELXS",
"GELFF" => "GPHQELXS",
"GCHARM" => "GPHCHMXS",
"GBARYONRESONANCE" => "GFWPARDAT",
"GBASE" => "GPHDISXS",
"GBODEKYANG" => "GPHDISXS",
"GCOH" => "GPHCOHEG GPHCOHXS"
		       ); }

foreach my $lib (sort keys %dir_list) {
   next if m&add_subdirectory&i;
   next if m&simple_plugin&i;
   next if m&SUBDIRNAME&i;
   next if m&SUBDIRS&i;
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}
# cleanup
s/\$\{GPHRESEG GPHRESXS\}/\$\{GPHRESEG\} \$\{GPHRESXS\}/g;
s/\$\{GPHNUELEG GPHNUELXS\}/\$\{GPHNUELEG\} \$\{GPHNUELXS\}/g;
s/\$\{GPHAMNGEG GPHAMNGXS\}/\$\{GPHAMNGEG\} \$\{GPHAMNGXS\}/g;
s/\$\{GPHMNUCEG GPHMNUCXS\}/\$\{GPHMNUCEG\} \$\{GPHMNUCXS\}/g;
s/\$\{GPHCOHEG GPHCOHXS\}/\$\{GPHCOHEG\} \$\{GPHCOHXS\}/g;

