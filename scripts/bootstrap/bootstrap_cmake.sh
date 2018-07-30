#!/bin/bash

#
# Download cmake repo
#
echo -e "\n##### Downloading cmake repo"
if [ ! -d /vagrant/tarballs ]; then
  mkdir /vagrant/tarballs
fi
cd /vagrant/tarballs
if [ ! -f gf-release-latest.gf.el7.noarch.rpm ]; then
  wget -nv http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
fi

#
# Install cmake 
#
echo -e "\n##### Installing cmake"
rpm -Uvh gf-release-latest.gf.el7.noarch.rpm
yum --enablerepo=gf-plus install -y cmake
cd -
