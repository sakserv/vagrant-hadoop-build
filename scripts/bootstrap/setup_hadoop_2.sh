HADOOP_VERSION=`grep "<version>" pom.xml | head -1 | awk -F'[<>]' '{print $3}'`
HADOOP_DIR=/usr/local/hadoop
echo "copying build to $HADOOP_DIR"
rm -rf $HADOOP_DIR
cp -r hadoop-dist/target/hadoop-$HADOOP_VERSION $HADOOP_DIR
echo "setting up conf dir"
cp -r /vagrant/conf/hadoop $HADOOP_DIR/conf
cp /vagrant/conf/hadoop/* $HADOOP_DIR/etc/hadoop/
echo "creating $HADOOP_DIR/logs"
mkdir -p $HADOOP_DIR/logs
chmod g+w $HADOOP_DIR/logs
echo "setting permissions"
chgrp -R hadoop $HADOOP_DIR
chmod 750 $HADOOP_DIR/bin/container-executor
chmod ug+s $HADOOP_DIR/bin/container-executor 
