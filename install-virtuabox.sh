#!/bin/bash

sudo apt update
sudo apt install virtualbox
mkdir $HOME/virtualbox 
vm setproperty machinefolder $HOME/virtualbox