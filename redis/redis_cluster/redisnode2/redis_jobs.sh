#!/bin/bash
#*****************************************************************************************
# Filename: redis_jobs.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: sh redis_jobs.sh
# Version: v1.0
#*****************************************************************************************

#!/bin/bash

LOCAL_IP=`ip addr | grep inet | grep -vE 'inet6 | 127.0.0.1' | awk '{print $2}' | awk -F '/' '{print $1}' | sed -n '1p'`

redis_start () {
redis-server /etc/redis/7001/redis.conf
sleep 1
redis-server /etc/redis/7002/redis.conf
}

redis_stop () {
redis-cli -c -h ${LOCAL_IP} -p 7001 shutdown
sleep 1
redis-cli -c -h ${LOCAL_IP} -p 7002 shutdown
}

case "$1" in
    start)
        echo "Start Redis Cluster..."
        redis_start
        RETVAL=$?
        if [ ${RETVAL} == 0 ];then
            echo "Starting is succeed!"
        fi
        ;;
    stop)
        echo "Stop Redis Cluster..."
        redis_stop
        RETVAL=$?
        if [ ${RETVAL} == 0 ];then
            echo "Stopping is succeed!"
        fi
        ;;
    restart)
        echo "Restart Redis Cluster..."
        sleep 1
        echo "Stop Redis Cluster..."
        redis_stop
        RETVAL=$?
        if [ ${RETVAL} == 0 ];then
            echo "Stopping is succeed!"
        fi
        sleep 1
        echo "Start Redis Cluster..."
        redis_start
        RETVAL=$?
        if [ ${RETVAL} == 0 ];then
            echo "Stopping is succeed!"
        fi
        ;;
    *)
        echo "Usage: ./redis_jobs.sh {start|stop|restart}"
        RETVAL=2
    ;;
esac
exit 0
