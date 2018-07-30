#!/bin/bash

#
# Variables
#
HADOOP_DIR=/usr/local/hadoop
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
# Setup the common configuration
#
echo -e "\n##### Setting up common configuration"
cp -r /vagrant/conf/common/hadoop $HADOOP_DIR/etc/


#
# Setup security
#
mode="simple"
if [ "$secure" = "true" ]; then
  mode="secure"
fi
echo -e "\n##### Setting up configuration for $mode security"
SEC_CONF_DIR=/vagrant/conf/$mode/hadoop
for conf in $(ls $SEC_CONF_DIR); do
  base_conf=$(echo $conf | sed 's|\.tail||g')
  echo -e "\tProcessing $base_conf"
  cat $SEC_CONF_DIR/$conf >> $HADOOP_DIR/etc/hadoop/$base_conf
done
