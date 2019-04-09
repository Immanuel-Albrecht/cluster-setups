#!/bin/bash

cd $(dirname $0)

MINIONS="$(./minion-names.sh)"

./delete-mini-server.sh
for name in $MINIONS ; do
./delete-micro-server.sh $name
done
