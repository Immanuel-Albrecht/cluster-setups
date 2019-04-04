#!/bin/bash

for (( retry=0; retry<10; retry+= 1 )) ; do
  if hcloud "$@" ; then break ; fi
  sleep 2
done
