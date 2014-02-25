#!/bin/bash

# This script only works on machines where /grid/fermiapp is mounted.

usage()
{
   echo "USAGE: `basename ${0}` [-v] <project> [date]"
   echo "        -v provides more verbose output"
   echo "        supported projects: larsoft, uboone, lbne"
   echo "        date must be of the form YYYY-MM-DD (default is today)"
}

provide_output()
{
   msg=${1}
   if [ -n "${verbose}" ]; then
      echo "${project} ${check_date}: ${1}"
   fi
  
}

nightly_build_dir=/grid/fermiapp/larsoft/home/larsoft/code
if [ ! -d ${nightly_build_dir} ]
then
   echo "ERROR: cannot find ${nightly_build_dir}"
   echo "    This script only works on machines where /grid/fermiapp is mounted."
   exit 1
fi

verbose=
case "$1" in
  -v)
    verbose=true
    shift
    ;;
  -*)
    echo "ERROR: unrecognized option $1" >&2
    usage
    exit 1
    ;;
esac

project=${1}
check_date=${2}
if [ -z ${1} ]
then 
   usage
   exit 1
fi
case "${project}" in
  "")
    usage
    exit 1
    ;;
  larsoft|uboone|lbne)
    nightly_subdir=${project}_nightly_build
    ;;
  *)
    echo "ERROR: unrecognized project ${project}"
    usage
    exit 1
    ;;
esac

TODAY="`date +%Y-%m-%d`"
if [ -z ${check_date} ]
then
   check_date=${TODAY}
else 
   date -d ${check_date} >& /dev/null
   status=$?
   if [ ${status} == 1 ]
   then
      echo "ERROR: invalid date ${check_date}"
      exit 1
   fi
fi

bad_build=false
stamp_dir=${nightly_build_dir}/${nightly_subdir}/stamps

if [ -e ${stamp_dir}/nightly_tag_${check_date} ]
then
   provide_output "nightly tag was successful"
else
   provide_output "nightly tag failed"
   bad_build=true
fi

for build_type in slf5_e4_debug slf5_e4_prof slf6_e4_debug slf6_e4_prof
do
   if [ -e ${stamp_dir}/nightly_build_${build_type}_${check_date} ]
   then 
      provide_output "nightly build for ${build_type} was successful"
   else
      provide_output "nightly build for ${build_type} failed"
      bad_build=true
   fi
done

if [ -e ${stamp_dir}/nightly_copy_${check_date} ]
then 
   provide_output "nightly copy was successful"
else
   provide_output "nightly copy failed"
   bad_build=true
fi

if [ "${bad_build}" == "true" ]
then
   echo "FAILURE: ${project} ${check_date} nightly update failed"
   echo "         log files are available in ${nightly_build_dir}/${nightly_subdir}/logs"
else
   echo "SUCCESS: ${project} ${check_date} nightly update succeeded"
fi

exit 0
