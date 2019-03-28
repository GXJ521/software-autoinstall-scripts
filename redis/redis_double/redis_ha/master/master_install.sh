#!/bin/bash
#*****************************************************************************************
# Filename: master_install.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-21
# Usage: sh master_install.sh
# Version: v1.0
#*****************************************************************************************

source /opt/redis_ha/master/scripts/rpms_install.sh
source /opt/redis_ha/master/scripts/redis_install.sh
source /opt/redis_ha/master/scripts/system_option.sh
source /opt/redis_ha/master/scripts/config.sh

Main_Fun () {
Install_Rpms | tee -a /opt/redis_ha/logs/rpm_install.log &>/dev/null
System_Option
Install_Redis | tee -a /opt/redis_ha/logs/redis_install.log &>/dev/null
Config_Redis
Config_Keep
}

Main_Fun
