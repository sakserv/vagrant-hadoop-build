pushd /apache-hadoop
/apache-maven/bin/mvn clean package -Pdist -Pnative -DskipTests -Dtar -Dcontainer-executor.additional_cflags="-DDEBUG" -Dmaven.javadoc.skip=true -DskipShade -rf :hadoop-yarn
popd
