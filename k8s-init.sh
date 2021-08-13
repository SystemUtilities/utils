#!/bin/sh
set -e

# Configure required sysctl to persist across system reboots
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
# Apply sysctl parameters without reboot to current running enviroment
sudo sysctl --system

sed -e '/    - --port=0/d' -i /etc/kubernetes/manifests/kube-controller-manager.yaml
sed -e '/    - --port=0/d' -i /etc/kubernetes/manifests/kube-scheduler.yaml

systemctl restart kubelet


# Access cluseter from non-root
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config 

# Access cluser from root
# export KUBECONFIG=/etc/kubernetes/admin.conf