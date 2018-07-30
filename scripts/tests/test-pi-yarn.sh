#!/bin/bash

export YARN_EXAMPLES_JAR=$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar
yarn jar $YARN_EXAMPLES_JAR pi 1 40000
