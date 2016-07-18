#!/bin/bash

function usage() {
   echo "USAGE: `basename ${0}` [-h] <directory>"
   echo "        -h  (this help)"
   echo "        look for classes_def.xml under the specified directory"
   echo "        If no directory is specified, search this directory"
}

case "$1" in
  -h)
    usage
    exit 0
    ;;
  -*)
    echo "ERROR: unrecognized option $1" >&2
    usage
    exit 1
    ;;
esac

xml_directory=${1}
if [ -z ${xml_directory} ];then
   xml_directory="."
fi

dict_files=`find ${xml_directory} -name classes_def.xml`
for xml_file in  ${dict_files}
do
  echo
  echo "check ${xml_file}"
  sort -u ${xml_file} | \
  grep -e 'Wrapper.*Assns' | \
  perl -wane 'BEGIN { @h = (); }
  m&.*Wrapper.*Assns\s*<(\S+?),\s*(\S+?)(?:,\s*(\S+?))?\s*>& and
   push @h, [ ${1}, ${2}, ${3} || "void" ];
  END { foreach my $f (@h) {
   grep { $_->[0] eq $f->[1] and
    $_->[1] eq $f->[0] and $_->[2] eq $f->[2]; } @h or 
     print "Missing selections for art::Assns<$f->[1], $f->[0], $f->[2]>\n";
   }; }'
done

exit 0
