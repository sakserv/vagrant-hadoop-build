#!/bin/bash

echo -e "\n##### Installing docker"
curl -fsSL https://get.docker.com/ | sh
mkdir -p /etc/docker
cp /vagrant/conf/common/os/daemon.json /etc/docker/daemon.json
service docker start
mkdir /root/.docker
cp /vagrant/conf/common/os/docker-config.json /root/.docker/config.json
