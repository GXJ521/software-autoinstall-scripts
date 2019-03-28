#!/bin/bash
#*****************************************************************************************
# Filename: redis_master.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-15
# Usage: sh redis_master.sh
# Version: v1.0
#*****************************************************************************************

REDISCLI="/usr/local/bin/redis-cli -h $1 -p $3"
LOGFILE="/var/log/redis/keepalived-redis-state.log"
echo "[master]" >> $LOGFILE
date >> $LOGFILE
echo "Being master...." >> $LOGFILE 2>&1
echo "Run SLAVEOF cmd ... " >> $LOGFILE
$REDISCLI SLAVEOF $2 $3 >> $LOGFILE  2>&1

#echo "SLAVEOF $2 cmd can't excute ... " >> $LOGFILE
sleep 10                                               #延迟10秒以后待数据同步完成后再取消同步状态
echo "Run SLAVEOF NO ONE cmd ..." >> $LOGFILE
$REDISCLI SLAVEOF NO ONE >> $LOGFILE 2>&1
