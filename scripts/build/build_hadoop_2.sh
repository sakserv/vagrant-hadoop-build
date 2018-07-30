/tmp/apache-maven/bin/mvn -o clean install -Pdist -Pnative -DskipTests -Dtar -Dcontainer-executor.additional_cflags="-DDEBUG" -Dmaven.javadoc.skip=true -DskipShade
