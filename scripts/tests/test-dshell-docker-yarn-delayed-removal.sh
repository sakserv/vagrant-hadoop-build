#!/bin/bash
export DSHELL_JAR=$HADOOP_HOME/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar

yarn jar $DSHELL_JAR -master_resources memory-mb=1024,vcores=1 -container_memory 1024 -shell_env YARN_CONTAINER_RUNTIME_DOCKER_DELAYED_REMOVAL=true -shell_env YARN_CONTAINER_RUNTIME_TYPE=docker -shell_env YARN_CONTAINER_RUNTIME_DOCKER_IMAGE="library/centos:latest" -shell_command "sleep 60" -jar $DSHELL_JAR -num_containers 1
