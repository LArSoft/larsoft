#!/bin/bash
# Program name
prog=${0##*/}
# ======================================================================
function usage() {
    cat 1>&2 <<EOF
usage: $prog <top-dir>
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

function fcl_file() {
  local F=$1
  printf "$F ... "
  # Optionally fix whitespace
  (( ${fix_whitespace:-0} )) && ed "$F" < fix-whitespace.ed > /dev/null 2>&1
  # Fix CMakeLists.txt 
  perl -wapi\~ -f ${thisdir}/fix_fcl.pl "${F}" >/dev/null 2>&1 && rm -f "${F}~"
}

# ======================================================================
# Prepare:
getopt -T >/dev/null 2>&1
if (( $? != 4 )); then
  echo "ERROR: GNU getopt required! Check SETUP_GETOPT and PATH." 1>&2
  exit 1
fi

TEMP=`getopt -n "$prog" -o a --long fix-whitespace -- "${@}"`
eval set -- "$TEMP"
while true; do
  case $1 in
    --fix-whitespace)
      fix_whitespace=1
      shift
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

TMP=`mktemp -t DealWithGaus.sh.XXXXXX`
trap "rm $TMP* 2>/dev/null" EXIT

  echo
  for F in `find $TOP -name "*.fcl" -print`; do
    fcl_file "$F"
  done
  echo
