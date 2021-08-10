#!/bin/sh
set -e
docker system prune -a
docker network prune -a
dpkg -l | grep -i docker
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
sudo apt-get autoremove -y --purge
sudo umount /var/lib/docker
sudo rm -rf /var/lib/docker \
    /etc/docker \
    /var/run/docker.sock \
    /usr/bin/docker-compose
sudo rm /etc/apparmor.d/docker
sudo groupdel docker