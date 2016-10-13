#!/bin/bash

# Implement the suggestion here:
# http://blog.neutrino.es/2012/git-copy-a-file-or-directory-from-another-repository-preserving-history/
# Note that if the file was moved, you only get history since the move.

usage()
{
   echo "USAGE: `basename ${0}` <repository> <file or directory>"
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

repo=${1}
myfile=${2}

if [ -z ${repo} ]; then
  usage
  exit 1
fi
if [ -z ${myfile} ]; then
  usage
  exit 1
fi

currentdir=`pwd`
get_this_dir
echo " script directory: ${thisdir}"
echo " current directory: ${currentdir}"

patchdir=${currentdir}/${repo}patch
mkdir -p ${patchdir}
cd ${currentdir}/${repo}/${repo}
reposrc=${myfile}
git format-patch -o ${patchdir} $(git log ${reposrc}|grep ^commit|tail -1|awk '{print $2}')^..HEAD ${reposrc}

exit 0

