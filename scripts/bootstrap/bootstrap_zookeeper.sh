#!/bin/bash

#
# Env
#
ZOOKEEPER_VERSION=3.4.13

#
# Download zk tarball
#
echo -e "\n##### Downloading zookeeper if needed"
if [ ! -d /vagrant/tarballs ]; then
  mkdir /vagrant/tarballs
fi
cd /vagrant/tarballs
if [ ! -f zookeeper-$ZOOKEEPER_VERSION.tar.gz ]; then
  wget -nv https://dist.apache.org/repos/dist/release/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz
fi

#
# Install zk
#
cd /tmp
echo -e "\n##### Installing zookeeper"
cp /vagrant/tarballs/zookeeper-$ZOOKEEPER_VERSION.tar.gz /tmp/
tar xzf zookeeper-$ZOOKEEPER_VERSION.tar.gz
cp /vagrant/conf/common/zookeeper/zoo.cfg /tmp/zookeeper-$ZOOKEEPER_VERSION/conf/
ln -s /tmp/zookeeper-$ZOOKEEPER_VERSION /tmp/zookeeper
