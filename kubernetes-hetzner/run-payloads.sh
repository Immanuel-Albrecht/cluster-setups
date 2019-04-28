#!/bin/bash

TARGET=root@$1

if [ -z "$3" ] ; then

retries=0
while true ; do

if scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r payloads $TARGET:'~' ; then
    break
fi

retries=$(( retries + 1 ))
echo "Retrying ... ($retries)"
sleep 10

done

while true ; do

if ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $TARGET 'chmod +x payloads/*' ; then
    break
fi

retries=$(( retries + 1 ))
echo "Retrying ... ($retries)"
sleep 10

done

else
	echo "skipping copying of the payloads"
fi

while true ; do

	if ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $TARGET "tmux new-session -d -s "$(basename $2)" $2" ; then
    break
fi

retries=$(( retries + 1 ))
echo "Retrying ... ($retries)"
sleep 10

done
