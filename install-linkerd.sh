#!/bin/bash

# `sh install-linkerd.sh` would not find `source`.
# Do `chmod +x install-linkerd.sh`.
# Execute `bash install-linkerd.sh`.

cd $HOME/bin
curl -sL https://run.linkerd.io/install | sh
echo 'export PATH=$PATH:$HOME/bin/.linkerd2/bin' >> ~/.bashrc
source ~/.bashrc