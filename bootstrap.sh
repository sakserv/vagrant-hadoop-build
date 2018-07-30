#!/bin/bash

#
# Vars
#
SCRIPT_NAME=$(basename $0)
SCRIPTS_DIR=/vagrant/scripts

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
# OS setup
#
$SCRIPTS_DIR/bootstrap/bootstrap_os.sh

#
# Set environment variables
#
$SCRIPTS_DIR/bootstrap/bootstrap_env.sh
. /etc/profile

#
# Install cmake
#
$SCRIPTS_DIR/bootstrap/bootstrap_cmake.sh

#
# Install zookeeper
#
$SCRIPTS_DIR/bootstrap/bootstrap_zookeeper.sh

#
# Install docker
#
$SCRIPTS_DIR/bootstrap/bootstrap_docker.sh

#
# Install maven
#
$SCRIPTS_DIR/bootstrap/bootstrap_maven.sh

#
# Init k8s
#
$SCRIPTS_DIR/bootstrap/bootstrap_k8s.sh

#
# Init hadoop-yarn cgroup
#
$SCRIPTS_DIR/bootstrap/bootstrap_yarncgroups.sh

#
# Configure krb and keytabs, if secure
#
if [ "$secure" = "true" ]; then
  $SCRIPTS_DIR/bootstrap/bootstrap_krb.sh
fi

#
# Stage hadoop source
#
$SCRIPTS_DIR/build/stage_hadoop_source.sh

#
# Build hadoop
#
$SCRIPTS_DIR/build/build_hadoop.sh

#
# Install Hadoop
#
$SCRIPTS_DIR/bootstrap/install_hadoop.sh

#
# Configure Hadoop
#
$SCRIPTS_DIR/bootstrap/configure_hadoop.sh -s $secure

#
# Format HDFS
#
echo -e "\n##### Formatting HDFS"
su - hdfs -c "/usr/local/hadoop/bin/hdfs namenode -format"

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
