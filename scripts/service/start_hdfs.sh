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
# NN
#
echo "starting namenode"
su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon start namenode"

#
# DN
#
echo "starting datanode"
if [ "$secure" = "true" ]; then
  $HADOOP_HOME/bin/hdfs --daemon start datanode
else
  su - hdfs -c "$HADOOP_HOME/bin/hdfs --daemon start datanode"
fi

#
# Sleep for safe mode
#
echo "sleeping while safe mode is on"
sleep 30
