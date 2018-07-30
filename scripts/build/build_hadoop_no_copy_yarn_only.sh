pushd /vagrant/apache-hadoop
/tmp/apache-maven/bin/mvn package -Pdist -Pnative -DskipTests -Dtar -Dcontainer-executor.additional_cflags="-DDEBUG" -Dmaven.javadoc.skip=true -DskipShade -rf :hadoop-yarn
popd
