#!/bin/sh

PRJ="kubernetes-test-233407"
NAME="std-cluster-1"
NODES="3"
MACHINE="n1-standard-1"


gcloud beta container --project "$PRJ" clusters create "$NAME" --zone "europe-west3-c" --username "admin" --cluster-version "1.11.7-gke.4" --machine-type "$MACHINE" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "$NODES" --enable-cloud-logging --enable-cloud-monitoring --no-enable-ip-alias --network "projects/$PRJ/global/networks/default" --subnetwork "projects/$PRJ/regions/europe-west3/subnetworks/default" --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair
