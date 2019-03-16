#!/bin/sh

PRJ="kubernetes-test-233407"
NAME="std-cluster-1"
NODES="3"
MACHINE="n1-standard-1"


gcloud beta container --project "$PRJ" clusters delete "$NAME" --zone "europe-west3-c" 
