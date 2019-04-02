#!/bin/sh

KEY_PARAMS=""
for i in $(hcloud ssh-key list | grep ':' | awk ' { print $1 } ') ; do
	KEY_PARAMS="$KEY_PARAMS --ssh-key $i"
done
echo $KEY_PARAMS
