#!/bin/sh

helm "$@" --tls --tls-ca-cert ~/.tiller/tls/ca.cert.pem --tls-cert ~/.tiller-tls/helm.cert.pem --tls-key ~/.tiller-tls/helm.key.pem
