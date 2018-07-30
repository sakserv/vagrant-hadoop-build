#!/bin/bash

#
# Variables
#
cd /apache-hadoop
HADOOP_VERSION=`grep "<version>" pom.xml | head -1 | awk -F'[<>]' '{print $3}'`
HADOOP_DIR=/usr/local/hadoop

#
# Stage the build
#
echo -e "\n##### Copying build to $HADOOP_DIR"
if [ -d $HADOOP_DIR ]; then
  rm -rf $HADOOP_DIR
fi
cp -r hadoop-dist/target/hadoop-$HADOOP_VERSION $HADOOP_DIR

#
# Create the log dir
#
echo -e "\n##### Creating $HADOOP_DIR/logs"
mkdir -p $HADOOP_DIR/logs
chmod g+w $HADOOP_DIR/logs

#
# Set permissions
#
echo -e "\n##### Setting permissions"
chgrp -R hadoop $HADOOP_DIR
chmod 750 $HADOOP_DIR/bin/container-executor 
chmod ug+s $HADOOP_DIR/bin/container-executor 

