#!/bin/bash
source /etc/profile

# ZK
cd /tmp/zookeeper
bin/zkServer.sh start
cd -
