#!/bin/bash
#*****************************************************************************************
# Filename: sqlplus_install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-04-24
# Usage: source sqlplus_install.sh
# Version: v1.0
#*****************************************************************************************

cd sqlplus_rpm/
sudo rpm -ivh oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
sudo rpm -ivh oracle-instantclient12.2-tools-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-jdbc-12.2.0.1.0-1.x86_64.rpm oracle-instantclient12.2-odbc-12.2.0.1.0-2.x86_64.rpm

echo "export ORACLE_HOME=/usr/lib/oracle/12.2/client64/" | tee -a ~/.bashrc
echo "export LD_LIBRARY_PATH=:\$ORACLE_HOME/lib:/usr/local/lib:\$LD_LIBRARY_PATH:."  | tee -a ~/.bashrc
echo "export TNS_ADMIN=\$ORACLE_HOME" | tee -a ~/.bashrc
echo "export PATH=\$PATH:\$ORACLE_HOME/bin:." | tee -a ~/.bashrc
source ~/.bashrc
