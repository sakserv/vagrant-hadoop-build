#!/bin/bash

#
# Envs
#
MAVEN_VERSION=3.5.2

#
# Download maven if needed
#
echo -e "\n##### Downloading maven, if needed"
if [ ! -d /vagrant/tarballs ]; then
  mkdir /vagrant/tarballs
fi
cd /vagrant/tarballs
if [ ! -f apache-maven-$MAVEN_VERSION-bin.tar.gz ]; then
  wget -nv https://dist.apache.org/repos/dist/release/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
fi
cd -

#
# Install maven
#
echo -e "\n##### Installing maven"
cd /tmp
mkdir -p ~/.m2
cp /vagrant/conf/common/os/settings.xml ~/.m2/
cp /vagrant/tarballs/apache-maven-$MAVEN_VERSION-bin.tar.gz /tmp/
tar xzf apache-maven-$MAVEN_VERSION-bin.tar.gz
ln -s /tmp/apache-maven-$MAVEN_VERSION /tmp/apache-maven
cd -
