#!/bin/bash
#*****************************************************************************************
# Filename: system_option.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source system_option.sh
# Version: v1.0
#*****************************************************************************************

System_Install () {
# 最大句柄数及最大进程数
echo "*   hard  nofile  65536" | tee -a /etc/security/limits.conf &>/dev/null
echo "*   soft  nofile  65536" | tee -a /etc/security/limits.conf &>/dev/null
echo "ulimit -n 65536" | tee -a /etc/profile &>/dev/null
echo "ulimit -n 65536" | tee -a  ~/.bashrc &>/dev/null
source /etc/profile
source ~/.bashrc

# 开启防火墙
/usr/bin/firewall-cmd --zone=public --add-port=7001/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=17001/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=7002/tcp --permanent
/usr/bin/firewall-cmd --zone=public --add-port=17002/tcp --permanent
firewall-cmd --reload

# 关闭selinux
setenforce 0
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
}
