#!/bin/bash

set -x

echo "Safety first: disable rpcbind for everyone..."

while ! [ -z "$(cat /etc/hosts.deny | grep '^rpcbind: ALL\$')" ] ; do
	echo "rpcbind: ALL" >> /etc/hosts.deny
done

echo "Allowing localhost to access rpcbind...."

while ! [ -z "$(cat /etc/hosts.allow | grep '^rpcbind: localhost\$')" ] ; do
	echo "rpcbind: localhost" >> /etc/hosts.allow
done

echo "Installing nfs-common and nfs-kernel-server..."

while true; do
	if apt-get install -y nfs-common nfs-kernel-server ; then
		break
	fi
	sleep 15 #Most commonly, apt-get fails when another apt-get process is running in the background....
done

echo "Conveniently creating some directories..."
mkdir -p /srv/nfs/data
mkdir -p /srv/nfs/tmp
mkdir -p /srv/nfs/output

echo "nfs.sh setup is done..."
