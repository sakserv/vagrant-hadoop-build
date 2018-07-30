#!/bin/bash
SCRIPT_PATH=$(cd `dirname $0` && pwd)
source /etc/profile

# RM
echo "stopping resourcemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon stop resourcemanager"

# RM
echo "starting resourcemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon start resourcemanager"
