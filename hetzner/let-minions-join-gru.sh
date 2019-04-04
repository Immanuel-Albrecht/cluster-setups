#!/bin/bash

cd $(dirname $0)

for minion in $(hcloud server list | awk ' { print $2 } ' | grep -v '\(gru\|NAME\)') ; do
	echo $minion wants to join gru...
	./join-master.sh gru "$minion"
done
