#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="gru"
fi

set -x
./hcloud.sh server create --name "$NAME" --type cx21 --image "ubuntu-18.04" `$(dirname $0)/get-ssh-key-parameters.sh`
