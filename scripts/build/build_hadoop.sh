#!/bin/bash

#
# Build hadoop
#
echo -e "\n##### Building hadoop"
cd /apache-hadoop
/tmp/apache-maven/bin/mvn clean install -Pdist -Pnative -DskipTests -Dtar -Dmaven.javadoc.skip=true -DskipShade || exit 1
