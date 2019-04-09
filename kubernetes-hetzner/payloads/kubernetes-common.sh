#!/bin/bash

set -x

while true ; do
    if apt-get install -y docker.io ; then
         break
    fi
    sleep 10
done

while true ; do
    if systemctl enable docker ; then
         break
    fi
    sleep 10
done

while true ; do
    if curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add ; then
         break
    fi
    sleep 10
done

while true ; do
    if apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" ; then
         break
    fi
    sleep 10
done

while true ; do
    if apt-get install -y kubeadm ; then
         break
    fi
    sleep 10
done

while true ; do
    if swapoff -a ; then
         break
    fi
    sleep 10
done

