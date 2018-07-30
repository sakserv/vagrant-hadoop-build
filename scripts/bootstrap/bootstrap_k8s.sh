#!/bin/bash

#
# Init k8s dirs
#
echo -e "\n##### Init k8s directories"
mkdir /var/lib/kubelet
mkdir /etc/kubernetes
mkdir /srv/kubernetes
mkdir /var/run/secrets

#
# k8s cgroup prep
#
echo -e "\n##### Configure cgroups for k8s"
echo "JoinControllers=cpu,cpuacct,cpuset,net_cls,net_prio,hugetlb,memory" >> /etc/systemd/system.conf
