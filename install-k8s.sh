#!/bin/bash
sudo apt update -y && sudo apt upgrade -y 
sudo apt install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# # Adding kubernetes-$(lsb_release -cs), i.e. focal source does not install kubelet and kubeadmin
# # echo "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl

#sudo rm -f /etc/default/kubelet
#echo KUBELET_EXTRA_ARGS=--feature-gates='AllAlpha=false,RunAsGroup=true' --container-runtime=remote --cgroup-driver=systemd --container-runtime-endpoint='unix:///var/run/crio/crio.sock' --runtime-request-timeout=5m | sudo tee -a /etc/default/kubelet 