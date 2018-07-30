#!/bin/bash

#
# Vars
#
SCRIPT_NAME=$(basename $0)

#
# Usage
#
usage() {
  echo -e "\n$SCRIPT_NAME [-s true/false]"
  echo -e "\t -s : true/false : use the secure Hadoop configuration"
  exit 1
}

#
# Parse CLI
#
while getopts ":s:" arg; do
  case $arg in
    s) secure="$OPTARG" ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))
[ -z "$secure" ] && usage
if [ "$secure" != "true" -a "$secure" != "false" ]; then
  usage
fi
echo -e "\n##### Security Enabled: $secure"

#
# Setup
#
source /etc/profile

#
# ZK
#
pushd /tmp/zookeeper
bin/zkServer.sh stop
popd

#
# NN
#
echo "stopping namenode"
su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon stop namenode"

#
# DN
#
echo "stopping datanode"
if [ "$secure" = "true" ]; then
  $HADOOP_HOME/bin/hdfs --daemon stop datanode
else
  su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon stop datanode"
fi

#
# RM
#
echo "stopping resourcemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon stop resourcemanager"

#
# NM
#
echo "stopping nodemanager"
su - yarn -c "$HADOOP_HOME/bin/yarn --daemon stop nodemanager"

#
# Registry DNS
#
echo "stopping registrydns"
$HADOOP_HOME/bin/yarn --daemon stop registrydns
