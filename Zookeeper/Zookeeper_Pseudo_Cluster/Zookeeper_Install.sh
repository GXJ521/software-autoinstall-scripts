#!/bin/bash
#*****************************************************************************************
# Filename: Zookeeper_Install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: sh Zookeeper_Install.sh
# Version: v1.0
#*****************************************************************************************

Jdk_Install () {
curl -o /opt/Zookeeper_Pseudo_Cluster/software/jdk-8u20-linux-x64.tar.gz http://file.mrlapulga.com/Jdk/jdk-8u20-linux-x64.tar.gz &>/dev/null
tar zxf /opt/Zookeeper_Pseudo_Cluster/software/jdk-8u20-linux-x64.tar.gz -C /opt
echo "export JAVA_HOME=/opt/jdk1.8.0_20" | tee -a /etc/profile &>/dev/null
echo "export JRE_HOME=\${JAVA_HOME}/jre" | tee -a /etc/profile &>/dev/null
echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" | tee -a /etc/profile &>/dev/null 
echo "export PATH=\$PATH:\${JAVA_HOME}/bin:\${JRE_HOME}/bin" | tee -a /etc/profile &>/dev/null
source /etc/profile
source /etc/profile
}

Zookeeper_Install () {
mkdir -p /opt/node{1..3}_zoo
curl -o /opt/Zookeeper_Pseudo_Cluster/software/zookeeper-3.4.13.tar.gz http://file.mrlapulga.com/Zookeeper/zookeeper-3.4.13.tar.gz
for n in `seq 3`
    do
    tar xf /opt/Zookeeper_Pseudo_Cluster/software/zookeeper-3.4.13.tar.gz -C /opt/node${n}_zoo
    mkdir -p /opt/node${n}_zoo/{data,logs}
    \cp  /opt/Zookeeper_Pseudo_Cluster/conf/zoo${n}.cfg /opt/node${n}_zoo/zookeeper-3.4.13/conf/zoo.cfg
    echo $n >/opt/node${n}_zoo/data/myid
    sed -i "26a ZOO_LOG_DIR=/opt/node${n}_zoo/log"  /opt/node${n}_zoo/zookeeper-3.4.13/bin/zkServer.sh
    echo -e "\033[36m*-----启动zookeeper节点${n}-----*\033[0m"
    /opt/node${n}_zoo/zookeeper-3.4.13/bin/zkServer.sh start &>/dev/null
    if [ $? -eq 0 ];then
        echo -e "\033[31m*-----zookeeper节点${n}启动成功\033[0m-----*"
    else
        echo -e "\033[31m*-----zookeeper节点${n}启动失败\033[0m-----*"
    fi
    sleep 2
done
}

System_Option () {
# 最大句柄数及最大进程数
echo "*   hard  nofile  65536" | tee -a /etc/security/limits.conf &>/dev/null
echo "*   soft  nofile  65536" | tee -a /etc/security/limits.conf &>/dev/null
echo "ulimit -n 65536" | tee -a /etc/profile &>/dev/null
echo "ulimit -n 65536" | tee -a  ~/.bashrc &>/dev/null
source /etc/profile
source ~/.bashrc

# 开启防火墙
/usr/bin/firewall-cmd --zone=public --add-port=2181/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=2182/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=2183/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=2888/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=3888/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=2889/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=3889/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=2890/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=3890/tcp --permanent
firewall-cmd --reload

# 关闭selinux
setenforce 0
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
}

read -p "是否安装JDK？如果安装请选择y，不安装请选择n: " yn
if [ ${yn} = y ];then
    System_Option
    Jdk_Install
    Zookeeper_Install
elif [ ${yn} = n ];then
    System_Option
    Zookeeper_Install
else
    exit 1
fi
