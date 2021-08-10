#!/bin/sh
set -e
sudo apt-get update -y
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default > /etc/containerd/config.toml