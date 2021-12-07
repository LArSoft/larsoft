use strict;


use vars qw(%dir_list);
BEGIN { %dir_list = (
        "GFWPARDAT" => "GENIE::GFwParDat",
        "GFWALG" => "GENIE::GFwAlg",
        "GPHDISXS" => "GENIE::GPhDISXS",
        "GPHPDF" => "GENIE::GPhPDF",
        "GPHXSIG" => "GENIE::GPhXSIg",
        "GPHDISEG" => "GENIE::GPhDISEG",
        "GPHHADNZ" => "GENIE::GPhHadnz",
        "GPHDCY" => "GENIE::GPhDcy",
        "GFWEG" => "GENIE::GFwEG",
        "GTLFLX" => "GENIE::GTlFlx",
        "GFWGHEP" => "GENIE::GFwGHEP",
        "GFWINT" => "GENIE::GFwInt",
        "GFWMSG" => "GENIE::GFwMsg",
        "GPHNUCLST" => "GENIE::GPhNuclSt",
        "GFWNUM" => "GENIE::GFwNum",
        "GFWREG" => "GENIE::GFwReg",
        "GPHCMN" => "GENIE::GPhCmn",
        "GFWUTL" => "GENIE::GFwUtl",
        "GFWNTP" => "GENIE::GFwNtp",
        "GPHHADTRANSP" => "GENIE::GPhHadTransp",
        "GPHDEEX" => "GENIE::GPhDeEx",
        "GPHAMNGXS" => "GENIE::GPhAMNGXS",
        "GPHAMNGEG" => "GENIE::GPhAMNGEG",
        "GPHCHMXS" => "GENIE::GPhChmXS",
        "GPHCOHXS" => "GENIE::GPhCohXS",
        "GPHCOHEG" => "GENIE::GPhCohEG",
        "GPHDFRCXS" => "GENIE::GPhDfrcXS",
        "GPHDFRCEG" => "GENIE::GPhDfrcEG",
        "GPHGLWRESXS" => "GENIE::GPhGlwResXS",
        "GPHGLWRESEG" => "GENIE::GPhGlwResEG",
        "GPHIBDXS" => "GENIE::GPhIBDXS",
        "GPHIBDEG" => "GENIE::GPhIBDEG",
        "GPHMNUCXS" => "GENIE::GPhMNucXS",
        "GPHMNUCEG" => "GENIE::GPhMNucEG",
        "GPHMEL" => "GENIE::GPhMEL",
        "GPHNUELXS" => "GENIE::GPhNuElXS",
        "GPHNUELEG" => "GENIE::GPhNuElEG",
        "GPHQELXS" => "GENIE::GPhQELXS",
        "GPHQELEG" => "GENIE::GPhQELEG",
        "GPHRESXS" => "GENIE::GPhResXS",
        "GPHRESEG" => "GENIE::GPhResEG",
        "GPHSTRXS" => "GENIE::GPhStrXS",
        "GPHSTREG" => "GENIE::GPhStrEG",
        "GPHNDCY" => "GENIE::GPhNDcy",
        "GTLGEO" => "GENIE::GTlGeo",
        "GRWFWK" => "GENIE::GRwFwk",
        "GRWIO" => "GENIE::GRwIO",
        "GRWCLC" => "GENIE::GRwClc",
        "LOG4CPP" => "log4cpp::log4cpp"
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
  #s&\b\Q${lib}\E([^\.\s]*\b)([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
  s&\b\Q${lib}\E\b([^\.]|$)&$dir_list{$lib}${1}${2}&g and last;
}

s&\$\{GSL\}&GSL&;
s&\$\{XML2\}&XML2&;
s&\$\{LOG4CPP\}&log4cpp::log4cpp&;
s&\$\{GFWMSG\}&GFWMSG&;
s&\$\{GFWREG\}&GFWREG&;
s&\$\{GFWALG\}&GFWALG&;
s&\$\{GFWINT\}&GFWINT&;
s&\$\{GFWGHEP\}&GFWGHEP&;
s&\$\{GFWNUM\}&GFWNUM&;
s&\$\{GFWUTL\}&GFWUTL&;
s&\$\{GFWPARDAT\}&GFWPARDAT&;
s&\$\{GFWEG\}&GFWEG&;
s&\$\{GFWNTP\}&GFWNTP&;
s&\$\{GPHXSIG\}&GPHXSIG&;
s&\$\{GPHPDF\}&GPHPDF&;
s&\$\{GPHNUCLST\}&GPHNUCLST&;
s&\$\{GPHCMN\}&GPHCMN&;
s&\$\{GPHHADTRANSP\}&GPHHADTRANSP&;
s&\$\{GPHHADNZ\}&GPHHADNZ&;
s&\$\{GPHDEEX\}&GPHDEEX&;
s&\$\{GPHAMNGXS\}&GPHAMNGXS&;
s&\$\{GPHAMNGEG\}&GPHAMNGEG&;
s&\$\{GPHCHMXS\}&GPHCHMXS&;
s&\$\{GPHCOHXS\}&GPHCOHXS&;
s&\$\{GPHCOHEG\}&GPHCOHEG&;
s&\$\{GPHDISXS\}&GPHDISXS&;
s&\$\{GPHDISEG\}&GPHDISEG&;
s&\$\{GPHDFRCXS\}&GPHDFRCXS&;
s&\$\{GPHDFRCEG\}&GPHDFRCEG&;
s&\$\{GPHGLWRESXS\}&GPHGLWRESXS&;
s&\$\{GPHGLWRESEG\}&GPHGLWRESEG&;
s&\$\{GPHIBDXS\}&GPHIBDXS&;
s&\$\{GPHIBDEG\}&GPHIBDEG&;
s&\$\{GPHHADTENS\}&GPHHADTENS&;
s&\$\{GPHMNUCXS\}&GPHMNUCXS&;
s&\$\{GPHMNUCEG\}&GPHMNUCEG&;
s&\$\{GPHMEL\}&GPHMEL&;
s&\$\{GPHNUELXS\}&GPHNUELXS&;
s&\$\{GPHNUELEG\}&GPHNUELEG&;
s&\$\{GPHQELXS\}&GPHQELXS&;
s&\$\{GPHQELEG\}&GPHQELEG&;
s&\$\{GPHRESXS\}&GPHRESXS&;
s&\$\{GPHRESEG\}&GPHRESEG&;
s&\$\{GPHSTRXS\}&GPHSTRXS&;
s&\$\{GPHSTREG\}&GPHSTREG&;
s&\$\{GPHNDCY\}&GPHNDCY&;
s&\$\{GPHDCY\}&GPHDCY&;
s&\$\{GTLGEO\}&GTLGEO&;
s&\$\{GTLFLX\}&GTLFLX&;
s&\$\{GRWFWK\}&GRWFWK&;
s&\$\{GRWIO\}&GRWIO&;
s&\$\{GRWCLC\}&GRWCLC&;
s&\$\{DK2NU_TREE\}&DK2NU_TREE&;
s&\$\{DK2NU_GENIE\}&DK2NU_GENIE&;
