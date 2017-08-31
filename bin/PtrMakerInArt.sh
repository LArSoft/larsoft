#!/bin/bash

for pfile in `ack -l PtrMaker`
do
  sed -i -e s%lardata/Utilities/PtrMaker.h%art/Persistency/Common/PtrMaker.h% $pfile
  sed -i -e s%lar::PtrMaker%art::PtrMaker%g $pfile
done

exit 0
