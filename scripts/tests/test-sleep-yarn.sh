#!/bin/bash

export YARN_EXAMPLES_JAR=$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-*-tests.jar
yarn jar $YARN_EXAMPLES_JAR sleep -m 1 -r 0 -mt 60000
