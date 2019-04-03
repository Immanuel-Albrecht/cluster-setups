#!/bin/bash

MASTER=root@$1
MINION=root@$2

JOIN_COMMAND=$(ssh $MASTER "kubeadm token create --print-join-command")
echo "Join command: $JOIN_COMMAND"
ssh $MINION "$JOIN_COMMAND"
