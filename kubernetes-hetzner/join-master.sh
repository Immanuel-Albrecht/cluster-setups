#!/bin/bash

MASTER=root@$1
MINION=root@$2

JOIN_COMMAND=$(ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $MASTER "kubeadm token create --print-join-command")
echo "Join command: $JOIN_COMMAND"
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $MINION "$JOIN_COMMAND"
