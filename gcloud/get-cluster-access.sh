#!/bin/sh

PRJ="kubernetes-test-233407"
NAME="std-cluster-1"
NODES="3"
MACHINE="n1-standard-1"

gcloud beta container clusters \
    --project "$PRJ" \
    get-credentials "$NAME" \
    --zone "europe-west3-c"
