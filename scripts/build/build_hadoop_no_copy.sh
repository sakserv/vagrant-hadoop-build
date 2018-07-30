#!/bin/bash

#
# Build hadoop
#
echo -e "\n##### Building hadoop"
cd /vagrant/apache-hadoop
/tmp/apache-maven/bin/mvn install -Pdist -Pnative -DskipTests -Dtar -Dmaven.javadoc.skip=true -DskipShade || exit 1
