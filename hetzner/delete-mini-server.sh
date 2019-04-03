#!/bin/sh

if ! [ -z "$1" ] ; then
	NAME="$1"
else
	NAME="gru"
fi

set -x
hcloud server delete "$NAME"
