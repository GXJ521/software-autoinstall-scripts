#!/bin/bash
#*****************************************************************************************
# Filename: redis_check.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-15
# Usage: sh redis_check.sh
# Version: v1.0
#*****************************************************************************************

ALIVE=`/usr/local/bin/redis-cli -h $1 -p $2 PING`
LOGFILE="/var/log/redis/keepalived-redis-check.log"
echo "[CHECK]" >> $LOGFILE
date >> $LOGFILE
if [ $ALIVE == "PONG" ]; then :
   echo "Success: redis-cli -h $1 -p $2 PING $ALIVE" >> $LOGFILE 2>&1
    exit 0
else
    echo "Failed:redis-cli -h $1 -p $2 PING $ALIVE " >> $LOGFILE 2>&1
    exit 1
fi
