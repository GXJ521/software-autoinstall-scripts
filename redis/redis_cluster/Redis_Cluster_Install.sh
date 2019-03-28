#!/bin/bash
#*****************************************************************************************
# Filename: Redis_Cluster_Install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: sh Redis_Cluster_Install.sh
# Version: v1.0
#*****************************************************************************************

# 读入三个节点IP地址
read -p "Please input node1 ip: " NODE1_IP
read -p "Please input node2 ip: " NODE2_IP
read -p "Please input node3 ip: " NODE3_IP

# 写入三个节点IP地址至文件
echo "NODE1_IP:${NODE1_IP}" > /opt/redis_cluster/redisnode1/conf/node1_ip.txt
echo "NODE2_IP:${NODE2_IP}" > /opt/redis_cluster/redisnode2/conf/node2_ip.txt
echo "NODE3_IP:${NODE3_IP}" > /opt/redis_cluster/redisnode3/conf/node3_ip.txt

# 免密
ssh-keygen -t rsa -P '' -f ~/.ssh/id_dsa
ssh-copy-id -i ~/.ssh/id_dsa.pub root@${NODE2_IP}
ssh-copy-id -i ~/.ssh/id_dsa.pub root@${NODE3_IP}

# 将部署包及脚本远程传至相应节点服务器
ssh root@${NODE2_IP} bash -c "'mkdir -p /opt/redis_cluster'"
ssh root@${NODE3_IP} bash -c "'mkdir -p /opt/redis_cluster'"
scp -r /opt/redis_cluster/redisnode2 root@${NODE2_IP}:/opt/redis_cluster/ &>/dev/null
scp -r /opt/redis_cluster/software root@${NODE2_IP}:/opt/redis_cluster/ &>/dev/null
scp -r /opt/redis_cluster/redisnode3 root@${NODE3_IP}:/opt/redis_cluster/ &>/dev/null
scp -r /opt/redis_cluster/software root@${NODE3_IP}:/opt/redis_cluster/ &>/dev/null

# 系统优化
source /opt/redis_cluster/redisnode1/options/system_option.sh
source /opt/redis_cluster/redisnode1/options/system_option.sh
System_Install
ssh root@${NODE2_IP} bash -c "'source /opt/redis_cluster/redisnode2/options/system_option.sh'"
ssh root@${NODE3_IP} bash -c "'source /opt/redis_cluster/redisnode3/options/system_option.sh'"


# 进行安装
source /opt/redis_cluster/redisnode1/redisall_install.sh
Redisall_Install
ssh root@${NODE2_IP} bash -c "'source /opt/redis_cluster/redisnode2/redisall_install.sh'"
ssh root@${NODE3_IP} bash -c "'source /opt/redis_cluster/redisnode3/redisall_install.sh'"

# 创建集群
/opt/redis-4.0.14/src/redis-trib.rb create --replicas 1 ${NODE1_IP}:7001 ${NODE1_IP}:7002 ${NODE2_IP}:7001 ${NODE2_IP}:7002 ${NODE3_IP}:7001 ${NODE3_IP}:7002
