#!/bin/sh
set -e

export OS=xUbuntu_$(lsb_release -rs)
export VERSION=$(curl --silent \
    "https://api.github.com/repos/kubernetes-sigs/cri-tools/releases/latest" \
    | grep tag_name | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-5)
sudo echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" \
    > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
sudo echo  "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" \
    > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key \
    | sudo apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key \
    | sudo apt-key add -
sudo apt update -y
sudo apt install -y cri-o cri-o-runc