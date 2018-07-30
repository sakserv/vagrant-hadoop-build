#!/bin/bash

export YARN_EXAMPLES_JAR=$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-*-tests.jar
IMAGE_ID="local/hadoop-build:latest"
yarn jar $YARN_EXAMPLES_JAR sleep -Dmapreduce.map.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$IMAGE_ID" -Dmapreduce.reduce.env="YARN_CONTAINER_RUNTIME_TYPE=docker,YARN_CONTAINER_RUNTIME_DOCKER_IMAGE=$IMAGE_ID" -m 1 -r 0 -mt 60000
