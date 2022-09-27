#!/bin/bash


usage()
{
   echo "USAGE: `basename ${0}` <file list>"
}

file_list=$@

if [ -z "${file_list}" ]; then
  usage
  exit 1
fi

for fl in ${file_list}; do
  #echo "remove trailing whitespace from ${fl}"
  #sed -i 's/[ \t]*$//g' ${fl}
  sed -Ei'' -e 's&[[:space:]]+$&&' ${fl}
done

exit 0

