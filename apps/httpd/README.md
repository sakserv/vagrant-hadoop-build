## Running httpd proxy app

Upload the httpd-proxy.conf template file to HDFS:
```
hdfs dfs -copyFromLocal /vagrant/apps/httpd/httpd-proxy.conf .
```

Launch service:
```
yarn service create --file /vagrant/apps/httpd/httpd.json
```

Once the docker containers are running, verify registry DNS has the entries:
```
nslookup httpd-proxy-0.httpd-service.root.ynsdev
nslookup httpd-0.httpd-service.root.ynsdev
nslookup httpd-1.httpd-service.root.ynsdev
```

Visit pages:
```
links http://httpd-0.httpd-service.root.ynsdev:8080
links http://httpd-1.httpd-service.root.ynsdev:8080
links http://httpd-proxy-0.httpd-service.root.ynsdev:8080
```

The httpd-0 page will say "Hello from httpd-0!".
The httpd-1 page will say "Hello from httpd-1!".
The httpd-proxy0 page will alternate between the two messages (somewhat randomly).

```
while (true); do echo `curl -s http://httpd-proxy-0.httpd-service.root.ynsdev:8080`; sleep 1; done
```
