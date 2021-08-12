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
# Configure required sysctl to persist across system reboots
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
# Apply sysctl parameters without reboot to current running enviroment
sudo sysctl --system

# Adding kubernetes-$(lsb_release -cs), i.e. 
# focal source does not install kubelet and kubeadmin.
# echo "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main" \
#   | sudo tee -a /etc/apt/sources.list.d/kubernetes.list