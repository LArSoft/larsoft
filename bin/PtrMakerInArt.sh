#!/bin/bash

for pfile in `ack -l PtrMaker`
do
  sed -i -e s%art/Persistency/Common/PtrMaker.h%art/Persistency/Common/PtrMaker.h% $pfile
  sed -i -e s%art::PtrMaker%art::PtrMaker%g $pfile
done

exit 0
