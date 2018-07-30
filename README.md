## Simple vagrant installation of Apace Hadoop trunk

Development VM for building and running Apache Hadoop from source.

Initial Build
-------------
0. Validate current.profile for the type of setup needed, mainly enabling security
```
{
  "domain": "yns.example.com",
  "box_name": "centos/7",
  "vm_mem": 8192,
  "vm_cpus": 8,
  "nodes": [
    { "hostname": "y7001", "ip": "192.168.70.211"}
  ],
  "secure": "false"
}
```

1. Clone this repo
```
git clone https://github.com/sakserv/vagrant-hadoop-build.git
cd vagrant-hadoop-build
```

2. Checkout the Hadoop source code (the output directory name needs to be apache-hadoop). This is the source to import into your IDE.
```
git clone https://github.com/apache/hadoop.git apache-hadoop
```

3. Build the VM. Hadoop will be installed to /usr/local/hadoop
```
vagrant up
```

Rebuild
-------
0. Make modifications to the apache-hadoop directory in the vagrant-hadoop-build checkout

1. Sync the Hadoop source (and maven repo cache) to the VM
```
vagrant rsync
```

2. Rebuild the VM. Two options are available. -s for secure and -w for wiping state. 
```
# sudo /vagrant/scripts/build/rebuild.sh -s false -w true

Usage:
rebuild.sh [-s true/false] [-w true/false]
	 -s : true/false : use the secure Hadoop configuration
	 -w : true/false : wipe hdfs and yarn data and state
```
