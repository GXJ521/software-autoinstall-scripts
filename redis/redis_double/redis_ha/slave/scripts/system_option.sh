#!/bin/bash
#*****************************************************************************************
# Filename: system_option.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-13
# Usage: source system_option.sh
# Version: v1.0
#*****************************************************************************************

System_Option () {
mkdir -p /data/redis /var/log/redis /etc/keepalived/scripts
groupadd redis
useradd redis -g redis -s /sbin/nologin -M
chown -R redis:redis /data/redis
chown -R redis:redis /var/log/redis
echo 511 > /proc/sys/net/core/somaxconn
echo "echo 511 > /proc/sys/net/core/somaxconn" >> /etc/rc.local
chmod +x /etc/rc.d/rc.local
echo 1 > /proc/sys/vm/overcommit_memory
echo "vm.overcommit_memory=1" >> /etc/sysctl.conf
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local
echo "/usr/local/bin/redis-server /etc/redis.conf" >> /etc/rc.local
setenforce 0
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
}
