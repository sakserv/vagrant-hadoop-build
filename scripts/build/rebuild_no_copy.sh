#!/bin/bash

#
# Vars
#
SCRIPTS_DIR=/vagrant/scripts
HADOOP_INST_DIR=/usr/local/hadoop
#
# Vars
#
SCRIPT_NAME=$(basename $0)

#
# Usage
#
usage() {
  echo -e "\n$SCRIPT_NAME [-s true/false] [-w true/false]"
  echo -e "\t -s : true/false : use the secure Hadoop configuration"
  echo -e "\t -w : true/false : wipe hdfs and yarn data and state"
  exit 1
}

#
# Parse CLI
#
while getopts ":s:w:" arg; do
  case $arg in
    s) secure="$OPTARG" ;;
    w) wipe="$OPTARG" ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))
[ -z "$secure" ] && usage
[ -z "$wipe" ] && usage
if [ "$secure" != "true" -a "$secure" != "false" ]; then
  usage
fi
if [ "$wipe" != "true" -a "$wipe" != "false" ]; then
  usage
fi
echo -e "\n##### Security Enabled: $secure"
echo -e "\n##### Wipe Enabled: $secure"

#
# Stop all services
#
echo -e "\n##### Stopping all services"
$SCRIPTS_DIR/service/stop_all.sh -s $secure

#
# Wipe the state if requested
#
if [ "$wipe" = "true" ]; then
  if [ -d /tmp/hadoop-yarn ]; then
    echo -e "\n##### Removing yarn state"
    rm -rf /tmp/hadoop-yarn
  fi

  if [ -d /tmp/hadoop-hdfs ]; then
    echo -e "\n##### Removing hdfs state"
    rm -rf /tmp/hadoop-hdfs
  fi
fi

#
# Remove hadoop inst root
#
echo -e "\n##### Removing hadoop from $HADOOP_INST_DIR"
rm -rf $HADOOP_INST_DIR

#
# Kill remaining apps
#
if [ "$wipe" = "true" ]; then
  echo -e "\n##### Killing any left over services"
  ps -ef | grep java | grep Service | awk '{print $2}' | xargs --no-run-if-empty kill -9
fi

#
# Build hadoop
#
$SCRIPTS_DIR/build/build_hadoop_no_copy.sh || exit 1

#
# Install Hadoop
#
$SCRIPTS_DIR/bootstrap/install_hadoop_no_copy.sh

#
# Configure Hadoop
#
$SCRIPTS_DIR/bootstrap/configure_hadoop.sh -s $secure

#
# Format HDFS
#
if [ "$wipe" = "true" ]; then
  echo -e "\n##### Formatting HDFS"
  su - hdfs -c "/usr/local/hadoop/bin/hdfs namenode -format"
fi

#
# Start zk
#
$SCRIPTS_DIR/service/start_zk.sh

#
# Start hdfs
#
$SCRIPTS_DIR/service/start_hdfs.sh -s $secure

#
# Create hdfs directories
#
$SCRIPTS_DIR/bootstrap/bootstrap_hdfs_dirs.sh -s $secure

#
# Start yarn
#
$SCRIPTS_DIR/service/start_yarn.sh

exit 0
