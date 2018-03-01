#!/bin/bash

for pfile in `ack -l "reconfigure(.*)override"`
do
  echo "checking ${pfile}"
  sed -i.bak -r "s%(.*void[[:space:]]+reconfigure\(.*\))[[:space:]]*override[[:space:]]*(.*)%\1 \2%g" ${pfile}
done

exit 0
