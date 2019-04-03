#!/bin/bash

TARGET=root@$1

mkdir -p ~/.kube

scp $TARGET:.kube/config ~/.kube/config
