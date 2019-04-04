#!/bin/bash

cd $(dirname $0)

./kubernetes-common.sh

echo "Waiting for command to join the master"

touch ~/minion-waiting-to-join
