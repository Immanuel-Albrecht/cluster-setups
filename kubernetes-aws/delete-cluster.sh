#!/bin/sh

NAME="ekstest"
NODES="3"

eksctl delete cluster --name $NAME 

#VPC="eks-vpc-stack"
#SECGROUP="sg-073cb5b5614e19057"
#VPCID="vpc-065d8cd80301bcce5"
#SUBNETS="subnet-043591d005200bb10,subnet-0d999e77b3650a26d,subnet-0d742f8328570155b"
#
#
#
#aws eks --region eu-central-1 create-cluster \
#   --name "$NAME" \
#   --role-arn "arn:aws:iam::899657499919:role/EKS-admin" \
#   --resources-vpc-config subnetIds=$SUBNETS,securityGroupIds=$SECGROUP
