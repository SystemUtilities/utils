#!/bin/sh
set -e
cd /usr/bin
curl -sL https://run.linkerd.io/install | sudo sh
echo 'export PATH=$PATH:$HOME/bin/.linkerd2/bin' >> ~/.bashrc
source ~/.bashrc