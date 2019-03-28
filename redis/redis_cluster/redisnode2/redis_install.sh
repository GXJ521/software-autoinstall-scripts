#!/bin/bash
#*****************************************************************************************
# Filename: redis_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source redis_install.sh
# Version: v1.0
#*****************************************************************************************

Redis_Install () {
tar zxf /opt/redis_cluster/software/redis-4.0.14.tar.gz -C /opt
cd /opt/redis-4.0.14
make
make install
mkdir -p /data/redis/{7001,7002} /var/log/redis /etc/redis/{7001,7002}
groupadd redis
useradd redis -g redis -s /sbin/nologin -M
chown -R redis.redis /data/redis /var/log/redis /etc/redis
cp /opt/redis_cluster/redisnode2/conf/redis_7001.conf /etc/redis/7001/redis.conf
cp /opt/redis_cluster/redisnode2/conf/redis_7002.conf /etc/redis/7002/redis.conf
NODE2_IP=`cat /opt/redis_cluster/redisnode2/conf/node2_ip.txt | awk -F':' '{print $2}'`
sed -i "s#10.1.1.154#${NODE2_IP}#g" /etc/redis/7001/redis.conf
sed -i "s#10.1.1.154#${NODE2_IP}#g" /etc/redis/7002/redis.conf
/bin/bash /opt/redis_cluster/redisnode2/redis_jobs.sh start
}
