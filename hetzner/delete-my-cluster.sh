#!/bin/bash

cd $(dirname $0)

MINIONS="dave stuart jerry jorge tim mark phil kevin bob" # jon is missing here...

./delete-mini-server.sh
for name in MINIONS ; do
./delete-micro-server.sh $name
done
