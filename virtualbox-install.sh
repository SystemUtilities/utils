#!/bin/sh
set -e
sudo apt update -y
sudo apt install -y virtualbox
mkdir $HOME/virtualbox
vboxmanage setproperty machinefolder $HOME/virtualbox