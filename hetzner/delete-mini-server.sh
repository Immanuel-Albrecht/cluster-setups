#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="timmey"
fi

set -x
hcloud server delete "$NAME"
