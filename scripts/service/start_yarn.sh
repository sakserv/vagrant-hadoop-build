#!/bin/bash
source /etc/profile

# RM
echo "starting resourcemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon start resourcemanager"

# NM
echo "starting nodemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon start nodemanager"

# Registry DNS
echo "starting registrydns"
$HADOOP_HOME/bin/yarn --daemon start registrydns
