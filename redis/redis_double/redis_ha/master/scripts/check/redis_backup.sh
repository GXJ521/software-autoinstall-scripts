#!/bin/bash
#*****************************************************************************************
# Filename: redis_backup.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-15
# Usage: sh redis_backup.sh
# Version: v1.0
#*****************************************************************************************

REDISCLI="/usr/local/bin/redis-cli"
LOGFILE="/var/log/keepalived-redis-state.log"
echo "[BACKUP]" >> $LOGFILE
date >> $LOGFILE
echo "Being slave...." >> $LOGFILE 2>&1
echo "Run SLAVEOF cmd ..." >> $LOGFILE 2>&1
$REDISCLI SLAVEOF $2 $3 >> $LOGFILE
sleep 10                                             #延迟100秒以后待数据同步完成后再取消同步状态
exit(0)
