#!/bin/bash

TARGET=root@$1

mkdir -p ~/.kube

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $TARGET:.kube/config ~/.kube/config
