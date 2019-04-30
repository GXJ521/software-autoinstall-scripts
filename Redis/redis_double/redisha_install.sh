#!/bin/bash
#*****************************************************************************************
# Filename: redisha_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-21
# Usage: sh redisha_install.sh
# Version: v1.0
#*****************************************************************************************

read -p "create public key ,please input slave host ip: " SLAVE_IP
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@${SLAVE_IP}

Var_Read () {
MASTERIP=`ip addr | grep inet | grep -vE 'inet6 | 127.0.0.1' | awk '{print $2}' | awk -F '/' '{print $1}' | sed -n '1p'`
SLAVEIP=${SLAVE_IP}
read -p "Please input VIP: " VIP
read -p "Please input network card name: " NET
read -p "Please input mask(numbers): " MASK
}

Log_Dir () {
mkdir -p /opt/redis_ha/logs
ssh root@${SLAVEIP} bash -c "'mkdir -p /opt/redis_ha/logs'"
}

Var_Write () {
echo "MASTERIP:${MASTERIP}" >> /opt/redis_ha/common/common.txt
echo "SLAVEIP:${SLAVEIP}" >> /opt/redis_ha/common/common.txt
echo "VIP:${VIP}" >> /opt/redis_ha/common/common.txt
echo "NET:${NET}" >> /opt/redis_ha/common/common.txt
echo "MASK:${MASK}" >> /opt/redis_ha/common/common.txt
}

Var_Read
Log_Dir
Var_Write

ssh root@${SLAVE_IP} bash -c "'mkdir -p /opt/redis_ha'"
scp -r redis_ha/slave root@${SLAVE_IP}:/opt/redis_ha &>/dev/null
scp -r redis_ha/common root@${SLAVE_IP}:/opt/redis_ha &>/dev/null

source redis_ha/master/master_install.sh

ssh root@${SLAVEIP} bash -c "'source /opt/redis_ha/slave/slave_install.sh'"

# start service
systemctl start keepalived
systemctl enable keepalived
redis-server /etc/redis.conf

ssh root@${SLAVEIP} bash -c "'systemctl start keepalived'"
ssh root@${SLAVEIP} bash -c "'systemctl enable keepalived'"
ssh root@${SLAVEIP} bash -c "'redis-server /etc/redis.conf'"
