pushd /tmp/zookeeper
bin/zkServer.sh start
popd
/usr/local/hadoop/sbin/hadoop-daemon.sh start namenode
/usr/local/hadoop/sbin/hadoop-daemon.sh start datanode
/usr/local/hadoop/sbin/yarn-daemon.sh start resourcemanager
/usr/local/hadoop/sbin/yarn-daemon.sh start nodemanager
/usr/local/hadoop/sbin/yarn-daemon.sh start servicesapi
