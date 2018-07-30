#!/bin/bash

echo -e "\n##### Setting env"
export PATH="/usr/local/hadoop/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/tmp/apache-maven/bin"
echo "export PATH=\"$PATH\"" >> /etc/profile
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/profile
echo "export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop" >> /etc/profile
echo "export HADOOP_HOME=/usr/local/hadoop" >> /etc/profile
