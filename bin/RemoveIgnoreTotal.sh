#!/bin/bash

echo $PWD

find $PWD -name "*.fcl" | xargs perl -wapi\~ -e 's&MemoryTracker:(\s*)\{\s*ignoreTotal\s*:\s*1\s*\}&MemoryTracker:$1\{ \}&;'

exit 0

