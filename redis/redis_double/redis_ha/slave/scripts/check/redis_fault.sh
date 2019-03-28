#!/bin/bash
#*****************************************************************************************
# Filename: redis_fault.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-15
# Usage: sh redis_fault.sh
# Version: v1.0
#*****************************************************************************************

LOGFILE="/var/log/redis/keepalived-redis-state.log"
echo "[fault]" >> $LOGFILE
date >> $LOGFILE
