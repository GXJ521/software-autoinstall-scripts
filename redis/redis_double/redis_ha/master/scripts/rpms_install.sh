#!/bin/bash
#*****************************************************************************************
# Filename: pms_install.sh
# Create by: liumanlin@zhizhangyi.com
# Create Data: 2019-03-21
# Usage: source rpms_install.sh
# Version: v1.0
#*****************************************************************************************

Install_Rpms () {
cd /opt/redis_ha/master/software/rpms/

# install gcc gcc-c++
rpm -Uvh libgcc-4.8.5-36.el7_6.1.x86_64.rpm glibc-common-2.17-260.el7_6.3.x86_64.rpm glibc-2.17-260.el7_6.3.x86_64.rpm
rpm -ivh mpfr-3.1.1-4.el7.x86_64.rpm libmpc-1.0.1-3.el7.x86_64.rpm cpp-4.8.5-36.el7_6.1.x86_64.rpm
rpm -Uvh libgomp-4.8.5-36.el7_6.1.x86_64.rpm
rpm -ivh kernel-headers-3.10.0-957.10.1.el7.x86_64.rpm glibc-headers-2.17-260.el7_6.3.x86_64.rpm glibc-devel-2.17-260.el7_6.3.x86_64.rpm gcc-4.8.5-36.el7_6.1.x86_64.rpm

# install keepalived
rpm -ivh net-snmp-libs-5.7.2-37.el7.x86_64.rpm \
perl-parent-0.225-244.el7.noarch.rpm \
perl-HTTP-Tiny-0.033-3.el7.noarch.rpm \
perl-podlators-2.5.1-3.el7.noarch.rpm \
perl-Pod-Perldoc-3.20-4.el7.noarch.rpm \
perl-Pod-Escapes-1.04-294.el7_6.noarch.rpm \
perl-Encode-2.51-7.el7.x86_64.rpm \
perl-Text-ParseWords-3.29-4.el7.noarch.rpm \
perl-Pod-Usage-1.63-3.el7.noarch.rpm \
perl-libs-5.16.3-294.el7_6.x86_64.rpm \
perl-macros-5.16.3-294.el7_6.x86_64.rpm \
perl-Storable-2.45-3.el7.x86_64.rpm \
perl-Exporter-5.68-3.el7.noarch.rpm \
perl-constant-1.27-2.el7.noarch.rpm \
perl-Time-Local-1.2300-2.el7.noarch.rpm \
perl-Socket-2.010-4.el7.x86_64.rpm \
perl-Carp-1.26-244.el7.noarch.rpm \
perl-Time-HiRes-1.9725-3.el7.x86_64.rpm \
perl-PathTools-3.40-5.el7.x86_64.rpm \
perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm \
perl-Pod-Simple-3.28-4.el7.noarch.rpm \
perl-File-Temp-0.23.01-3.el7.noarch.rpm \
perl-File-Path-2.09-2.el7.noarch.rpm \
perl-threads-shared-1.43-6.el7.x86_64.rpm \
perl-threads-1.87-4.el7.x86_64.rpm \
perl-Filter-1.49-3.el7.x86_64.rpm \
perl-Getopt-Long-2.40-3.el7.noarch.rpm \
perl-5.16.3-294.el7_6.x86_64.rpm \
lm_sensors-libs-3.4.0-6.20160601gitf9185e5.el7.x86_64.rpm \
net-snmp-agent-libs-5.7.2-37.el7.x86_64.rpm \
keepalived-1.3.5-8.el7_6.x86_64.rpm
}
