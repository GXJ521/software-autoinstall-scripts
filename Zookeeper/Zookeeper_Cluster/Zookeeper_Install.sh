#!/bin/bash
#*****************************************************************************************
# Filename: Zookeeper_Install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source Zookeeper_Install.sh
# Version: v1.0
#*****************************************************************************************

# 下载软件
curl -o /opt/Zookeeper_Cluster/software/zookeeper-3.4.13.tar.gz http://file.mrlapulga.com/Zookeeper/zookeeper-3.4.13.tar.gz
curl -o /opt/Zookeeper_Cluster/software/jdk-8u20-linux-x64.tar.gz http://file.mrlapulga.com/Jdk/jdk-8u20-linux-x64.tar.gz

# 读入三个节点IP地址
read -p "Please input node1 ip: " NODE1_IP
read -p "Please input node2 ip: " NODE2_IP
read -p "Please input node3 ip: " NODE3_IP

# 修改实际IP
sed -i "s#NODE1_IP#${NODE1_IP}#g" /opt/Zookeeper_Cluster/conf/zoo.cfg
sed -i "s#NODE2_IP#${NODE2_IP}#g" /opt/Zookeeper_Cluster/conf/zoo.cfg
sed -i "s#NODE3_IP#${NODE3_IP}#g" /opt/Zookeeper_Cluster/conf/zoo.cfg

# 免密
ssh-keygen -t rsa -P '' -f ~/.ssh/id_dsa
ssh-copy-id -i ~/.ssh/id_dsa.pub root@${NODE2_IP}
ssh-copy-id -i ~/.ssh/id_dsa.pub root@${NODE3_IP}

# 传输文件
ssh root@${NODE2_IP} bash -c "'mkdir -p /opt/Zookeeper_Cluster'"
ssh root@${NODE3_IP} bash -c "'mkdir -p /opt/Zookeeper_Cluster'"
scp -r /opt/Zookeeper_Cluster/conf root@${NODE2_IP}:/opt/Zookeeper_Cluster &>/dev/null
scp -r /opt/Zookeeper_Cluster/conf root@${NODE3_IP}:/opt/Zookeeper_Cluster &>/dev/null
scp -r /opt/Zookeeper_Cluster/software root@${NODE2_IP}:/opt/Zookeeper_Cluster &>/dev/null
scp -r /opt/Zookeeper_Cluster/software root@${NODE3_IP}:/opt/Zookeeper_Cluster &>/dev/null
scp -r /opt/Zookeeper_Cluster/zk_node2 root@${NODE2_IP}:/opt/Zookeeper_Cluster &>/dev/null
scp -r /opt/Zookeeper_Cluster/zk_node3 root@${NODE3_IP}:/opt/Zookeeper_Cluster &>/dev/null

# 系统优化
source /opt/Zookeeper_Cluster/zk_node1/system_option.sh
System_Option
ssh root@${NODE2_IP} bash -c "'source /opt/Zookeeper_Cluster/zk_node2/system_option.sh'"
ssh root@${NODE3_IP} bash -c "'source /opt/Zookeeper_Cluster/zk_node3/system_option.sh'"

# 安装
source /opt/Zookeeper_Cluster/zk_node1/zookeeper_install.sh
Jdk_Install
Zookeeper_Install
ssh root@${NODE2_IP} bash -c "'/opt/Zookeeper_Cluster/zk_node2/zookeeper_install.sh'"
ssh root@${NODE3_IP} bash -c "'/opt/Zookeeper_Cluster/zk_node3/zookeeper_install.sh'"
