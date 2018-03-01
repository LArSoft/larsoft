#!/bin/bash

sed -r "s/(.*void[[:space:]]+reconfigure\(.*\))[[:space:]]*override[[:space:]]*(.*)/\1 \2/g” <input files>
