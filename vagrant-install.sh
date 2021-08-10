#!/bin/sh
set -e
cd /tmp
export VERSION=$(curl -s https://api.github.com/repos/hashicorp/vagrant/tags \
    | jq ".[0].name" | cut -c 3-8)
curl -O https://releases.hashicorp.com/vagrant/$VERSION/vagrant_{$VERSION}_x86_64.deb
chmod 755 vagrant_$(echo $VERSION)_x86_64.deb
sudo apt install ./\vagrant_$(echo $VERSION)_x86_64.deb
rm -f vagrant_$(echo $VERSION)_x86_64.deb