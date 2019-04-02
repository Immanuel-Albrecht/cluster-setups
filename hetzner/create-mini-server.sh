#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="timmey"
fi

set -x
hcloud server create --name "$NAME" --type cx21 --image "ubuntu-18.04" `$(dirname $0)/get-ssh-key-parameters.sh`
