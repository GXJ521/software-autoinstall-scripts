#!/bin/bash
#*****************************************************************************************
# Filename: rpm_ruby_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-03-25
# Usage: source rpm_ruby_install.sh
# Version: v1.0
#*****************************************************************************************

Rpm_Ruby_Install () {
cd /opt/redis_cluster/software/rpms/rubys
rpm -ivh ruby-libs-2.0.0.648-34.el7_6.x86_64.rpm \
libyaml-0.1.4-11.el7_0.x86_64.rpm \
ruby-irb-2.0.0.648-34.el7_6.noarch.rpm \
ruby-2.0.0.648-34.el7_6.x86_64.rpm \
rubygem-bigdecimal-1.2.0-34.el7_6.x86_64.rpm \
rubygem-io-console-0.4.2-34.el7_6.x86_64.rpm \
rubygem-rdoc-4.0.0-34.el7_6.noarch.rpm \
rubygem-json-1.7.7-34.el7_6.x86_64.rpm \
rubygems-2.0.14.1-34.el7_6.noarch.rpm \
rubygem-psych-2.0.0-34.el7_6.x86_64.rpm \
rubygem-redis-3.2.1-2.el7.noarch.rpm
}
