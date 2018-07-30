#!/bin/bash

#
# Stage the source
#
echo -e "\n##### Staging hadoop source"
if [ -d "/apache-hadoop" ]; then
  rm -rf /apache-hadoop
fi
cp -rp /vagrant/apache-hadoop /
