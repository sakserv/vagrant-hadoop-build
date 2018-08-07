#!/bin/bash

#
# Copy the OS configs
#
echo -e "\n##### Copying OS configs"
cp /vagrant/conf/common/os/hosts /etc/hosts
cp /vagrant/conf/common/os/resolv.conf /etc/resolv.conf
cp /vagrant/conf/common/os/tmp.conf /usr/lib/tmpfiles.d/tmp.conf

#
# Setup the users and groups
#
echo -e "\n##### Setting up users and groups"
groupadd hadoop
useradd -G hadoop hdfs
useradd -G hadoop yarn
useradd -G hadoop zookeeper
useradd hadoopuser

#
# Setup hadoopuser sudo rules for privileged containers
#
cp /vagrant/conf/common/os/hadoopuser-sudo /etc/sudoers.d/hadoopuser

#
# Install packages
#
echo -e "\n##### Installing EPEL Repo"
yum install -y epel-release

echo -e "\n##### Installing OS packages"
yum install -y java-1.8.0-openjdk-devel nc git zlib-devel glibc-headers gcc-c++ openssl-devel net-tools links bind-utils jsvc jsoncpp protobuf-devel libgsasl-devel jq wget
