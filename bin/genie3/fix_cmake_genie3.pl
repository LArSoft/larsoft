use strict;

use vars qw(%dir_list);
BEGIN { %dir_list = (
  '${GALGORITHM}' => '${GFWALG}',
  '${GBARYONRESONANCE}' => '${GFWPARDAT}',
  '${GBASE}' => '${GPHDISXS}',
  '${GBERGERSEHGAL}' => '${GPHCOHXS}',
  '${GBODEKYANG}' => '${GPHDISXS}',
  '${GCHARM}' => '${GPHCHMXS}',
  '${GCROSSSECTIONS}' => '${GPHXSIG}',
  '${GDECAY}' => '${GPHDCY}',
  '${GDFRC}' => '${GPHDFRCEG}',
  '${GDIS}' => '${GPHDISEG}',
  '${GELAS}' => '${GPHQELXS}',
  '${GELFF}' => '${GPHQELXS}',
  '${GEVGCORE}' => '${GFWEG}',
  '${GEVGDRIVERS}' => '${GFWEG}',
  '${GEVGMODULES}' => '${GPHCMN}',
  '${GFLUXDRIVERS}' => '${GTLFLX}',
  '${GFRAGMENTATION}' => '${GPHHADNZ}',
  '${GGEO}' => '${GTLGEO}',
  '${GGIBUU}' => '${GPHRESXS}',
  '${GHADRONTRANSP}' => '${GPHHADTRANSP}',
  '${GHEP}' => '${GFWGHEP}',
  '${GINTERACTION}' => '${GFWINT}',
  '${GLLEWELLYNSMITH}' => '${GPHQELXS}',
  '${GMESSENGER}' => '${GFWMSG}',
  '${GMUELOSS}' => '${GPHMEL}',
  '${GNEUTRONOSC}' => '${GPHNNBAROSC}',
  '${GNTUPLE}' => '${GFWNTP}',
  '${GNUCLEAR}' => '${GPHNUCLST}',
  '${GNUCLEONDECAY}' => '${GPHNDCY}',
  '${GNUMERICAL}' => '${GFWNUM}',
  '${GPDF}' => '${GPHPDF}',
  '${GPDG}' => '${GFWPARDAT}',
  '${GQEL}' => '${GPHQELEG}',
  '${GQPM}' => '${PHDISXS}',
  '${GREGISTRY}' => '${GFWREG}',
  '${GREINSEHGAL}' => '${GPHRESXS}',
  '${GREWEIGHT}' => '${GTLREW}',
  '${GNUGAMMA}' => '${GPHAMNGEG} ${GPHAMNGXS}',
  '${GNUE}' => '${GPHNUELEG} ${GPHNUELXS}',
  '${GMEC}' => '${GPHMNUCEG} ${GPHMNUCXS}',
  '${GSINGLEKAON}' => '${GPHSTREG} ${GPHSTRXS}',
  '${GRES}' => '${GPHRESEG} ${GPHRESXS}',
  '${GCOH}' => '${GPHCOHEG} ${GPHCOHXS}',
  '${GALVAREZRUSO}' => '${GPHCOHXS} ${GFWNUM}',
  '${GVHE}' => '${GPHGLWRESEG} ${GPHGLWRESXS}',
  '${GVLE}' => '${GPHIBDEG} ${GPHIBDXS}',
  '${GUTILS}' => '${GFWUTL}'
    ); }

next if m&add_subdirectory&i;
next if m&simple_plugin&i;
next if m&SUBDIRNAME&i;
next if m&SUBDIRS&i;
next unless m&\$\{&;

foreach my $lib (sort keys %dir_list) {
  s&\Q$lib\E&$dir_list{"$lib"}&g;
}
