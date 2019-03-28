#!/bin/bash
#*****************************************************************************************
# Filename: config.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-21
# Usage: source config.sh
# Version: v1.0
#*****************************************************************************************

Config_Redis () {
\cp /opt/redis_ha/slave/conf/redis_conf/redis.conf /etc/redis.conf
sed -i "s#192.168.3.177#${MASTERIP}#g" /etc/redis.conf
}

Config_Keep () {
\cp /opt/redis_ha/slave/conf/keep_conf/keepalived.conf.slave /etc/keepalived/keepalived.conf
sed -i "s#NET#${NET}#g" /etc/keepalived/keepalived.conf
sed -i "s#VIP#${VIP}#g" /etc/keepalived/keepalived.conf
sed -i "s#MASTERIP#${MASTERIP}#g" /etc/keepalived/keepalived.conf
sed -i "s#SLAVEIP#${SLAVEIP}#g" /etc/keepalived/keepalived.conf
sed -i "s#MASK#${MASK}#g" /etc/keepalived/keepalived.conf
}

