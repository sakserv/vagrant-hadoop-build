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
  echo -e "\n$SCRIPT_NAME [-t /path/to/src.tgz]"
  echo -e "\t -t : /path/to/src.tgz : the path of the release source tarball to install"
  exit 1
}

#
# Parse CLI
#
while getopts ":s:w:t:" arg; do
  case $arg in
    t) src_tgz="$OPTARG" ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))
[ ! -f "$src_tgz" ] && usage
echo -e "\n##### Source tgz to stage: $src_tgz"

#
# Stage the source
#
echo -e "\n##### Setup source dir"
if [ -d "/apache-hadoop" ]; then
  rm -rf /apache-hadoop
fi
mkdir /apache-hadoop

#
# Extract the tarball
#
echo -e "\n##### Extracting $src_tgz"
tar -xzvf $src_tgz --strip-components=1 -C /apache-hadoop/

exit 0
