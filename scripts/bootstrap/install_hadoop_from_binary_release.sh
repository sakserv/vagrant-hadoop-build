#!/bin/bash

#
# Vars
#
SCRIPT_NAME=$(basename $0)
HADOOP_DIR=/usr/local/hadoop

#
# Usage
#
usage() {
  echo -e "\n$SCRIPT_NAME [-t /path/to/binary.tgz]"
  echo -e "\t -t : /path/to/binary.tgz : the path of the release binary tarball to install"
  exit 1
}

#
# Parse CLI
#
while getopts ":t:" arg; do
  case $arg in
    t) bin_tgz="$OPTARG" ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))
[ ! -f "$bin_tgz" ] && usage
echo -e "##### Binary tgz to install: $bin_tgz"

#
# Stage the build
#
echo -e "\n##### Creating hadoop install directory"
if [ -d $HADOOP_DIR ]; then
  rm -rf $HADOOP_DIR
fi
mkdir -p $HADOOP_DIR

#
# Extract the binary tgz
#
echo -e "\n##### Extracting binary release: $bin_tgz"
tar -xvzf $bin_tgz --strip-components=1 -C $HADOOP_DIR

#
# Fix ownership
#
echo -e "\n##### Fixing ownership"
chown -R root:hadoop $HADOOP_DIR

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

