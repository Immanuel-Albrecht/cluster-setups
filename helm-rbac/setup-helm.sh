#!/bin/sh

cd $(dirname $0)

if ! [ -d ~/.tiller-tls ] ; then
    ./setup-crypto.sh
fi

cat <<EOF | kubectl create -f /dev/stdin
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF

helm init --service-account tiller --history-max 20 --tiller-tls --tiller-tls-cert ~/.tiller-tls/tiller.cert.pem --tiller-tls-key ~/.tiller-tls/tiller.key.pem --tiller-tls-verify --tls-ca-cert ~/.tiller-tls/ca.cert.pem

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'


echo "Verifying..."
sleep 20

helm ls --tls --tls-ca-cert ~/.tiller/tls/ca.cert.pem --tls-cert ~/.tiller-tls/helm.cert.pem --tls-key ~/.tiller-tls/helm.key.pem

