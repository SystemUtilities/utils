#!/bin/sh
set -e
sudo kubeadm reset
sudo apt purge kubectl kubeadm kubelet kubernetes-cni -y
sudo apt autoremove
sudo rm -rf /etc/kubernetes \
    ~/.kube \
    /var/lib/etcd \
    /var/lib/cni
sudo systemctl daemon-reload
sudo iptables -F \
    && sudo iptables -t nat -F \
    && sudo iptables -t mangle -F \
    && sudo iptables -X