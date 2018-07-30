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
# kinit if security is enabled
if [ "$secure" = "true" ]; then
  hdfs_kinit="kinit -kt /etc/security/keytabs/nn.service.keytab nn/y7001.yns.example.com"
  su - hdfs -c "$hdfs_kinit"
fi

# Setup tmp
echo "setup hdfs tmp directory"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp" 
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chown hdfs:hadoop /tmp" 
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chmod 1777 /tmp" 

# Setup RM state store
echo "setup RM state store directory"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /rmstore" 
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chown yarn:hadoop /rmstore" 

# Setup log agg dir
echo "setup log aggregation directory"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /app-logs" 
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chown yarn:hadoop /app-logs" 
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chmod 1777 /app-logs"

# Setup user dir
echo "setup user directory"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /user"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chown hdfs:hadoop /user" 

# Setup hadoopuser home
echo "setup hadoopuser user directory"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -mkdir /user/hadoopuser"
su - hdfs -c "$HADOOP_HOME/bin/hdfs dfs -chown hadoopuser:hadoop /user/hadoopuser"
