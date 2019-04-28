#!/bin/bash
#*****************************************************************************************
# Filename: Mysql56_Install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-04-28
# Usage: sh Mysql56_Install.sh
# Version: v1.0
#*****************************************************************************************

Mysql_Install () {

# 下载
sudo curl -o /opt/mysql-5.6.40-linux-glibc2.12-x86_64.tar.gz http://file.mrlapulga.com/Mysql/software/generic/mysql-5.6.40-linux-glibc2.12-x86_64.tar.gz

# 设置变量
source /etc/init.d/functions
MYSQL_PKG_PATH='/opt/mysql-5.6.40-linux-glibc2.12-x86_64.tar.gz'
DEPLOY_PATH='/opt'
USER=mysql

# 准备
echo -e "*-----准备安装mysql-----*" 
sudo useradd mysql -s /sbin/nologin -M
sudo mkdir -p /data/mysql
sudo tar xf ${MYSQL_PKG_PATH} -C ${DEPLOY_PATH} 
sudo ln -sv  ${DEPLOY_PATH}/mysql-5.6.40-linux-glibc2.12-x86_64 ${DEPLOY_PATH}/mysql 
sudo chown -R ${USER}.${USER} ${DEPLOY_PATH}/mysql
sudo chown -R ${USER}.${USER} ${DEPLOY_PATH}/mysql/
sudo chown -R ${USER}.${USER} /data/mysql

# 初始化
cd ${DEPLOY_PATH}/mysql
sudo scripts/mysql_install_db --user=${USER} --basedir=${DEPLOY_PATH}/mysql --datadir=/data/mysql &>/dev/null 
sudo chown -R ${USER}.${USER} /data/mysql
if [ $? -eq 0 ];then
    action "*-----初始化Mysql-----*"   /bin/true
else
    action "*-----初始化Mysql-----*"   /bin/false
fi

# 配置启动脚本
sudo ln -s /opt/mysql/bin/mysql /usr/bin/ 
sudo sed -i '46s#basedir=#basedir=/opt/mysql#' support-files/mysql.server
sudo sed -i '47s#datadir=#datadir=/data/mysql#' support-files/mysql.server
sudo sed -i 's#basedir=/usr/local/mysql#basedir=/opt/mysql#' support-files/mysql.server
sudo sed -i 's#sbindir=/usr/local/mysql/bin#sbindir=/opt/mysql/bin#' support-files/mysql.server
sudo sed -i 's#bindir=/usr/local/mysql/bin#bindir=/opt/mysql/bin#' support-files/mysql.server
sudo sed -i 's#datadir=/usr/local/mysql/data#datadir=/data/mysql#' support-files/mysql.server
sudo sed -i 's#libexecdir=/usr/local/mysql/bin#libexecdir=/opt/mysql/bin#' support-files/mysql.server
sudo \cp support-files/mysql.server /etc/init.d/mysqld 
sudo chown -R ${USER}.${USER} /etc/init.d/mysqld

# 配置文件
sudo rm -f /etc/my.cnf
sudo bash -c "cat > /etc/my.cnf" <<EOF
[mysqld]
lower_case_table_names = 1
default-storage-engine = InnoDB
port = 3306
datadir = /data/mysql/
character-set-server = utf8
log_bin=mysql-bin
binlog_format = mixed
server_id = 1
innodb_buffer_pool_size = 1024M
slave-parallel-workers = 8
thread_cache_size = 600
back_log = 600
slave_net_timeout = 60
max_binlog_size = 512M
key_buffer_size = 8M
query_cache_size = 64M
join_buffer_size = 2M
sort_buffer_size = 2M
query_cache_type = 1
thread_stack = 192K
innodb_thread_concurrency = 8
connect_timeout = 300
max_connections = 6000
max_allowed_packet = 128M
max_connect_errors = 6000
wait_timeout = 240
interactive_timeout = 240
table_open_cache = 256
innodb_write_io_threads = 16
innodb_read_io_threads = 16
innodb_flush_log_at_trx_commit = 2
slow_query_log = 1
long_query_time = 1
lower_case_table_names = 1
skip-name-resolve
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
EOF
sudo chown -R ${USER}.${USER} /etc/my.cnf

# 启动mysql
echo -e "*-----启动mysql-----*" 
/etc/init.d/mysqld start

# 修改密码
sudo /opt/mysql/bin/mysqladmin -uroot password ")&09@zzy.com"
if [ $? -eq 0 ];then
    action "*-----初始化Mysql密码-----*"  /bin/true
else
    action "*-----初始化Mysql密码-----*"  /bin/false
fi
echo "PATH=/opt/mysql/bin:\$PATH" | sudo tee -a /etc/profile &>/dev/null
}

Mysql_Install
