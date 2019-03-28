#!/bin/bash
#*****************************************************************************************
# Filename: redis_install.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-21
# Usage: source redis_install.sh
# Version: v1.0
#*****************************************************************************************

Install_Redis () {
cd /opt/redis_ha/master/software
tar zxf redis-4.0.14.tar.gz -C /opt
cd /opt/redis-4.0.14
make && make install &>/dev/null
\cp /opt/redis_ha/master/scripts/check/* /etc/keepalived/scripts
chmod +x /etc/keepalived/scripts/*
}
