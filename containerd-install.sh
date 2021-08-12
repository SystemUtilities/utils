#!/bin/sh
set -e
sudo modprobe overlay
sudo modprobe br_netfilter
sudo apt-get update -y
sudo apt-get install -y containerd
sudo cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sudo mkdir -p /etc/containerd
sudo containerd config default > /etc/containerd/config.toml
sudo sed -i -e 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd