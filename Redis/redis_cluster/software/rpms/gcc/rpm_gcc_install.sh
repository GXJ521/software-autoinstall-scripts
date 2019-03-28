#!/bin/bash
#*****************************************************************************************
# Filename: rpm_gcc_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source rpm_gcc_install.sh
# Version: v1.0
#*****************************************************************************************

Rpm_Gcc_Install () {
cd /opt/redis_cluster/software/rpms/gcc
rpm -Uvh libgcc-4.8.5-36.el7_6.1.x86_64.rpm \
glibc-common-2.17-260.el7_6.3.x86_64.rpm \
glibc-2.17-260.el7_6.3.x86_64.rpm
rpm -ivh mpfr-3.1.1-4.el7.x86_64.rpm \
libmpc-1.0.1-3.el7.x86_64.rpm \
cpp-4.8.5-36.el7_6.1.x86_64.rpm
rpm -Uvh libgomp-4.8.5-36.el7_6.1.x86_64.rpm
rpm -ivh kernel-headers-3.10.0-957.10.1.el7.x86_64.rpm \
glibc-headers-2.17-260.el7_6.3.x86_64.rpm \
glibc-devel-2.17-260.el7_6.3.x86_64.rpm \
gcc-4.8.5-36.el7_6.1.x86_64.rpm
}
