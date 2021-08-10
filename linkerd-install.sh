#!/bin/sh
set -e
cd $HOME/bin
curl -sL https://run.linkerd.io/install | sh
echo 'export PATH=$PATH:$HOME/bin/.linkerd2/bin' >> ~/.bashrc
source ~/.bashrc