#!/bin/bash

TARGET=root@$1

for ((retries=0; retries<20; retries+= 1 )) ; do

if scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r payloads $TARGET:'~' ; then
    break
fi

echo "Retrying ... ($retries)"
sleep 10

done

for ((retries=0; retries<20; retries+= 1 )) ; do

if ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $TARGET 'chmod +x payloads/*' ; then
    break
fi

echo "Retrying ... ($retries)"
sleep 10

done

for ((retries=0; retries<20; retries+= 1 )) ; do

if ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $TARGET "tmux new-session -d -s setup-session $2" ; then
    break
fi

echo "Retrying ... ($retries)"
sleep 10

done
