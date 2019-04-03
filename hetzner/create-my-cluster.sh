#!/bin/bash

cd $(dirname $0)

MINIONS="dave stuart jerry jorge tim mark phil kevin bob" # jon is missing here...

./create-mini-server.sh
for name in MINIONS ; do
./create-micro-server.sh $name
done
