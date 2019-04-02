#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="gunnar"
fi

set -x
hcloud server create --name "$NAME" --type cx11 --image "ubuntu-18.04" `$(dirname $0)/get-ssh-key-parameters.sh`
