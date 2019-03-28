#!/bin/bash
#*****************************************************************************************
# Filename: master_install.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-21
# Usage: sh slave_install.sh
# Version: v1.0
#*****************************************************************************************

Common_Var () {
MASTERIP=`grep 'MASTERIP' /opt/redis_ha/common/common.txt | awk -F':' '{print $2}'`
SLAVEIP=`grep 'SLAVEIP' /opt/redis_ha/common/common.txt | awk -F':' '{print $2}'`
VIP=`grep 'VIP' /opt/redis_ha/common/common.txt | awk -F':' '{print $2}'`
NET=`grep 'NET' /opt/redis_ha/common/common.txt | awk -F':' '{print $2}'`
MASK=`grep 'MASK' /opt/redis_ha/common/common.txt | awk -F':' '{print $2}'`
}
Common_Var

source /opt/redis_ha/slave/scripts/rpms_install.sh
source /opt/redis_ha/slave/scripts/redis_install.sh
source /opt/redis_ha/slave/scripts/system_option.sh
source /opt/redis_ha/slave/scripts/config.sh

Main_Fun () {
Install_Rpms | tee -a /opt/redis_ha/logs/rpm_install.log &>/dev/null
System_Option
Install_Redis | tee -a /opt/redis_ha/logs/redis_install.log &>/dev/null
Config_Redis
Config_Keep
}

Main_Fun
