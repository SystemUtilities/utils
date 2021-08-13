#!/bin/sh
set -e
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
    https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
    https://apt.kubernetes.io/ kubernetes-xenial main" \
    | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y && apt-get upgrade -y
apt-get install -y kubeadm kubectl kubelet
apt-mark hold kubeadm kubectl kubelet

# Adding kubernetes-$(lsb_release -cs), i.e. 
# focal source does not install kubelet and kubeadmin.
# echo "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main" \
#   | sudo tee -a /etc/apt/sources.list.d/kubernetes.list