#!/bin/bash
# First parameter: number of minions

cd $(dirname $0)

MINIONS="dave stuart jerry jorge tim mark phil kevin bob jon"

if ! [ -z "$1" ] ; then
COUNT="$1"
else
COUNT=4
fi

./create-mini-server.sh # creates gru

IDX="$COUNT"

for name in $MINIONS ; do
  if [ $IDX -gt 0 ] ; then
	./create-micro-server.sh $name
	IDX=$((IDX - 1))
  fi
done

sleep 5

./add-ips-to-hosts.sh

./run-payloads.sh gru 'payloads/kubernetes-master.sh'

IDX="$COUNT"

for name in $MINIONS ; do
  if [ $IDX -gt 0 ] ; then
	./run-payloads.sh $name 'payloads/kubernetes-minion.sh'
	IDX=$((IDX - 1))
  fi
done

