#!/bin/bash
#*****************************************************************************************
# Filename: redis_fault.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-15
# Usage: sh redis_fault.sh
# Version: v1.0
#*****************************************************************************************

LOGFILE="/var/log/redis/keepalived-redis-state.log"
echo "[fault]" >> $LOGFILE
date >> $LOGFILE
