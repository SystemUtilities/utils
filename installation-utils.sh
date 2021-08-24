#!/bin/sh
set -e
sudo apt-get update -y && sudo apt upgrade -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    jq