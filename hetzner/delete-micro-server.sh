#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="gunnar"
fi

set -x
./hcloud.sh server delete "$NAME"
