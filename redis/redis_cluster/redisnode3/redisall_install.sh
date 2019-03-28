#!/bin/bash
#*****************************************************************************************
# Filename: redisall_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source redisall_install.sh
# Version: v1.0
#*****************************************************************************************

Redisall_Install () {
source /opt/redis_cluster/software/rpms/gcc/rpm_gcc_install.sh
source /opt/redis_cluster/redisnode3/redis_install.sh
source /opt/redis_cluster/software/rpms/rubys/rpm_ruby_install.sh

Rpm_Gcc_Install | tee -a /opt/redis_cluster/redisnode3/logs/rpm_gcc_install.log &>/dev/null
Redis_Install | tee -a /opt/redis_cluster/redisnode3/logs/redis_install.log &>/dev/null
Rpm_Ruby_Install | tee -a /opt/redis_cluster/redisnode3/logs/rpm_ruby_install.log &>/dev/null
}

Redisall_Install
