#!/bin/bash

cd $(dirname $0)

./kubernetes-common.sh

echo "Setting up kubernetes master node..."

set -x

kubeadm init  --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

kubectl create --namespace kube-system -f https://github.com/coreos/flannel/raw/master/Documentation/k8s-manifests/kube-flannel-legacy.yml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl create -f /dev/stdin <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
EOF

kubectl create -f /dev/stdin <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF

TOKEN_NAME=$(kubectl describe serviceAccounts admin-user -n kube-system | grep Tokens: | awk  '{print $2}')

kubectl describe secrets $TOKEN_NAME -n kube-system | grep 'token:' | awk '{print $2}' > $HOME/dashboard-admin-token

kubectl apply --filename https://git.io/weave-kube-1.6
