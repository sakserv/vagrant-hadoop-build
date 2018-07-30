pushd /apache-hadoop

#
# Variables
#
HADOOP_VERSION=`grep "<version>" pom.xml | head -1 | awk -F'[<>]' '{print $3}'`
HADOOP_DIR=/usr/local/hadoop

#
# Setup kerberos, if not already done
#
if [ ! -f /tmp/bootstrap_krb.complete ]; then
  $SCRIPT_PATH/bootstrap_krb.sh
fi

#
# Stage the build
#
echo -e "\n##### Copying build to $HADOOP_DIR"
rm -rf $HADOOP_DIR
cp -r hadoop-dist/target/hadoop-$HADOOP_VERSION $HADOOP_DIR

#
# Setup the common configuration
#
echo -e "\n##### Setting up common configuration"
cp -r /vagrant/conf/common/hadoop $HADOOP_DIR/conf
cp /vagrant/conf/common/hadoop/* $HADOOP_DIR/etc/hadoop/

#
# Setup kerberos security
#
echo -e "\n##### Setting up configuration for kerberos security"
SECURE_CONF_DIR=/vagrant/conf/secure/hadoop
for conf in $(ls /vagrant/conf/secure/hadoop); do
  base_conf=$(echo $conf | sed 's|\.tail||g')
  echo -e "\tProcessing $base_conf"
  cat $SECURE_CONF_DIR/$conf >> $HADOOP_DIR/etc/hadoop/$base_conf
done

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

popd
