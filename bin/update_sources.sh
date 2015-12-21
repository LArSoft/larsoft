#!/bin/bash
# Program name
prog=${0##*/}
# ======================================================================
function usage() {
    cat 1>&2 <<EOF
usage: $prog [--one-file <file>] <top-dir>
EOF
}

get_this_dir() 
{
    ( cd / ; /bin/pwd -P ) >/dev/null 2>&1
    if (( $? == 0 )); then
      pwd_P_arg="-P"
    fi
    reldir=`dirname ${0}`
    thisdir=`cd ${reldir} && /bin/pwd ${pwd_P_arg}`
}

##  perl -wapi\~ -f fix-header-locs.pl "${F}" >/dev/null 2>&1 && rm -f "${F}~"

function one_file() {
  local F=$1
  printf "$F ... "
  # Optionally fix whitespace
  (( ${fix_whitespace:-0} )) && ed "$F" < fix-whitespace.ed > /dev/null 2>&1
  # Fix includes 
  perl -wapi\~ -f ${thisdir}/fix_headers.pl "${F}" >/dev/null 2>&1 && rm -f "${F}~"
}

function cmake_file() {
  local F=$1
  printf "$F ... "
  # Optionally fix whitespace
  (( ${fix_whitespace:-0} )) && ed "$F" < fix-whitespace.ed > /dev/null 2>&1
  # Fix CMakeLists.txt 
  perl -wapi\~ -f ${thisdir}/fix_plugin_refs.pl "${F}" >/dev/null 2>&1 && rm -f "${F}~"
}

# ======================================================================
# Prepare:
getopt -T >/dev/null 2>&1
if (( $? != 4 )); then
  echo "ERROR: GNU getopt required! Check SETUP_GETOPT and PATH." 1>&2
  exit 1
fi

TEMP=`getopt -n "$prog" -o a --long all-lumi-cases --long one-file: --long no-fix-pset -- "${@}"`
eval set -- "$TEMP"
while true; do
  case $1 in
    --fix-whitespace)
      fix_whitespace=1
      shift
      ;;
    --one-file)
      file=$2
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Bad argument \"$OPT\"" 1>&2
      usage
      exit 1
    esac
done

TOP=${1}

get_this_dir

# ======================================================================
# Run scripts to update

TMP=`mktemp -t update_sources.sh.XXXXXX`
trap "rm $TMP* 2>/dev/null" EXIT

if [[ -n "${file}" ]]; then
  if ! [[ -r "${file}" ]]; then
    echo "ERROR: ${file} does not exist or is not readable." 1>&2
    exit 1
  else
    one_file "$file"
  fi
else
  for F in `find $TOP \( -type d \( -name .git -o -name .svn -o -name CVS -o -name ups -o -path '*/tools/migration' -o -path '*/art/ParameterSet' \) \
                       -prune \) -o -type f \! \( -name '*~' -o -name '*.bak' -o -name '*.orig' -o -name '*.new' -o -name '*.gdml' -o -name '*.py' -o -name '*.sh' -o -name '*.o' -o -name '*.so' -o -name '*.os' -o -name '*.root' -o -name '*.txt'  -o -name '*.tex' -o -name 'SConscript' \) -print`; do
    one_file "$F"
  done
  for F in `find $TOP -name CMakeLists.txt -print`; do
    cmake_file "$F"
    # now undo DumpTracks_module.cc change
    sed -i.bak -e's%larreco_TrackFinder_DumpTracks_module.cc%DumpTracks_module.cc%g' $F
  done
fi
