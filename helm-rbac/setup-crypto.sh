#!/bin/bash

rm -Rf ~/.tiller-tls

mkdir -p ~/.tiller-tls

cd ~/.tiller-tls

# CA's key

openssl genrsa -out ./ca.key.pem 4096

# Tiller's key
openssl genrsa -out tiller.key.pem 4096

# Client's key
openssl genrsa -out helm.key.pem 4096

echo "Enter information for the CA's certificate..."
openssl req -key ca.key.pem -new -x509 -days 7300 -sha256 -out ca.cert.pem -extensions v3_ca

echo "Enter information for Tiller's certificate..."

# Tiller's certificate
openssl req -key tiller.key.pem -new -sha256 -out tiller.csr.pem

echo "Enter information for Helm's certificate..."

# Helm's certificate
openssl req -key helm.key.pem -new -sha256 -out helm.csr.pem

echo "Signing certificates..."

# sign Tiller's certificate
openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in tiller.csr.pem -out tiller.cert.pem -days 365

# sign Helm's certificate
openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in helm.csr.pem -out helm.cert.pem  -days 365

