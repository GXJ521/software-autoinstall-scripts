#!/bin/bash
#*****************************************************************************************
# Filename: zookeeper_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source zookeeper_install.sh
# Version: v1.0
#*****************************************************************************************

Jdk_Install () {
tar zxf /opt/Zookeeper_Cluster/software/jdk-8u20-linux-x64.tar.gz -C /opt
echo "export JAVA_HOME=/opt/jdk1.8.0_20" | tee -a /etc/profile &>/dev/null
echo "export JRE_HOME=\${JAVA_HOME}/jre" | tee -a /etc/profile &>/dev/null
echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" | tee -a /etc/profile &>/dev/null
echo "export PATH=\$PATH:\${JAVA_HOME}/bin:\${JRE_HOME}/bin" | tee -a /etc/profile &>/dev/null
source /etc/profile
source /etc/profile
}

Zookeeper_Install () {
mkdir -p /opt/zknode
tar xf /opt/Zookeeper_Cluster/software/zookeeper-3.4.13.tar.gz -C /opt/zknode
mkdir -p /opt/zknode/{data,logs}
\cp  /opt/Zookeeper_Cluster/conf/zoo.cfg /opt/zknode/zookeeper-3.4.13/conf/zoo.cfg
echo "2" >/opt/zknode/data/myid
sed -i "26a ZOO_LOG_DIR=/opt/zknode/log"  /opt/zknode/zookeeper-3.4.13/bin/zkServer.sh
echo -e "\033[36m*-----启动zookeeper节点2-----*\033[0m"
/opt/zknode/zookeeper-3.4.13/bin/zkServer.sh start &>/dev/null
if [ $? -eq 0 ];then
    echo -e "\033[31m*-----zookeeper节点2启动成功\033[0m-----*"
else
    echo -e "\033[31m*-----zookeeper节点2启动失败\033[0m-----*"
fi
    sleep 2
}

Jdk_Install
Zookeeper_Install
