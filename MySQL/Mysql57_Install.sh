#!/bin/bash
#*****************************************************************************************
# Filename: Mysql57_Install.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-04-24
# Usage: sh Mysql57_Install.sh
# Version: v1.0
#*****************************************************************************************

# 安装依赖
yum install libaio -y

# 下载解压创建目录
curl -o /opt/mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz http://file.mrlapulga.com/Mysql/software/generic/mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz
tar -zxf /opt/mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz -C /opt
ln -sv /opt/mysql-5.7.24-linux-glibc2.12-x86_64 /opt/mysql
mkdir -p /data/mysql

# 修改启动脚本
sed -i '46s#basedir=#basedir=/opt/mysql#' /opt/mysql/support-files/mysql.server
sed -i '47s#datadir=#datadir=/data/mysql#' /opt/mysql/support-files/mysql.server
cp /opt/mysql/support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld

# 创建用户
groupadd mysql
useradd -r -g mysql -s /bin/false mysql

# 赋予所属组
chown -R mysql.mysql /opt/mysql/
chown -R mysql.mysql /data/mysql
chown -R mysql.mysql /etc/my.cnf
chown -R mysql.mysql /etc/init.d/mysqld

# 初始化
/opt/mysql/bin/mysqld --initialize --user=mysql --basedir=/opt/mysql --datadir=/data/mysql >> /tmp/init_mysql.log

# 过滤初始密码
mysql_passwd=$(grep "password" /tmp/init_mysql.log | awk -F' ' '{print $11}')

# 创建配置文件
rm -f /etc/my.cnf
cat >> /etc/my.cnf <<EOF
[mysqld]
#************** basic ***************
datadir                             = /data/mysql
basedir                             = /opt/mysql
port                                = 3306
socket                              = /data/mysql/mysql.sock
pid_file                            = /data/mysql/mysql.pid

#************** connection ***************
max_connections                     = 30000
max_connect_errors                  = 100000
max_user_connections                = 6000
check_proxy_users                   = on
mysql_native_password_proxy_users   = on
local_infile                        = OFF
symbolic-links                      = FALSE

#************** sql timeout & limits ***************
max_join_size                       = 1000000
max_execution_time                  = 10000
lock_wait_timeout                   = 60
autocommit                          = 1
lower_case_table_names              = 1
thread_cache_size                   = 64
disabled_storage_engines            = "MyISAM,FEDERATED"
character_set_server                = utf8
transaction-isolation               = "READ-COMMITTED"
skip_name_resolve                   = ON
explicit_defaults_for_timestamp     = ON
log_timestamps                      = SYSTEM
local_infile                        = OFF
event_scheduler                     = OFF
query_cache_type                    = OFF
query_cache_size                    = 0
#lc_messages                        = en_US
#lc_messages_dir                    = /data/mysql/share
init_connect                        = "set names utf8"
#sql_mode                           = NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO
sql_mode                            = NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
init_file                           = /data/mysql/init_file.sql
#init_slave

#******************* err & slow & general ***************
log_error                               = /data/mysql/mysql.err
#log_output                             = "TABLE,FILE"
slow_query_log                          = ON
slow_query_log_file                     = /data/mysql/slow.log
long_query_time                         = 1
log_queries_not_using_indexes           = ON
log_throttle_queries_not_using_indexes  = 10
general_log                             = OFF
general_log_file                        = /data/mysql/general.log

#************** binlog & relaylog ***************
expire_logs_days                    = 99
sync_binlog                         = 1
#log-bin                            = /data/mysql/blog/mysql-bin
#log-bin-index                      = /data/mysql/blog/mysql-bin.index
max_binlog_size                     = 500M
binlog_format                       = ROW
binlog_rows_query_log_events        = ON
binlog_cache_size                   = 128k
binlog_stmt_cache_size              = 128k
max_binlog_cache_size               = 2G
max_binlog_stmt_cache_size          = 2G
#relay_log                          = /data/mysql/blog/relay
#relay_log_index                    = /data/mysql/blog/relay.index
max_relay_log_size                  = 500M
relay_log_purge                     = ON
relay_log_recovery                  = ON

#*************** rpl_semi_sync ***************
#rpl_semi_sync_master_enabled                = ON
#rpl_semi_sync_master_timeout                = 1000
#rpl_semi_sync_master_trace_level            = 32
#rpl_semi_sync_master_wait_for_slave_count   = 1
#rpl_semi_sync_master_wait_no_slave          = ON
#rpl_semi_sync_master_wait_point             = AFTER_SYNC
#rpl_semi_sync_slave_enabled                 = ON
#rpl_semi_sync_slave_trace_level             = 32

#*************** group commit ***************
#binlog_group_commit_sync_delay              =1
#binlog_group_commit_sync_no_delay_count     =1000

#*************** gtid ***************
#gtid_mode                          = ON
#enforce_gtid_consistency           = ON
#master_verify_checksum             = ON
#sync_master_info                   = 1

#*************slave ***************
#skip-slave-start                   = 1
##read_only                         = ON
##super_read_only                   = ON
#log_slave_updates                  = ON
#server_id                          = 336001
#report_host                        = 172.31.40.45
#report_port                        = 3360
#slave_load_tmpdir                  = /msdata/db_mysql/tmp
#slave_sql_verify_checksum          = ON
#slave_preserve_commit_order        = 1

#*************** muti thread slave ***************
#slave_parallel_type                = LOGICAL_CLOCK
#slave_parallel_workers             = 4
#master_info_repository             = TABLE
#relay_log_info_repository          = TABLE

#*************** buffer & timeout ***************
read_buffer_size                    = 1M
read_rnd_buffer_size                = 2M
sort_buffer_size                    = 1M
join_buffer_size                    = 1M
tmp_table_size                      = 64M
max_allowed_packet                  = 64M
max_heap_table_size                 = 64M
connect_timeout                     = 10
wait_timeout                        = 600
interactive_timeout                 = 600
net_read_timeout                    = 30
net_write_timeout                   = 30

#*********** myisam ***************
skip_external_locking               = ON
key_buffer_size                     = 16M
bulk_insert_buffer_size             = 16M
concurrent_insert                   = ALWAYS
open_files_limit                    = 65000
table_open_cache                    = 16000
table_definition_cache              = 16000

#*********** innodb ***************
default_storage_engine              = InnoDB
default_tmp_storage_engine          = InnoDB
internal_tmp_disk_storage_engine    = InnoDB
innodb_data_home_dir                = /data/mysql
#innodb_log_group_home_dir          = /data/mysql/rlog
innodb_log_file_size                = 1024M
innodb_log_files_in_group           = 3
#innodb_undo_directory              = /data/mysql/ulog
innodb_undo_log_truncate            = on
innodb_max_undo_log_size            = 1024M
innodb_undo_tablespaces             = 0
innodb_flush_log_at_trx_commit      = 2
innodb_fast_shutdown                = 1
#innodb_flush_method                = O_DIRECT
innodb_io_capacity                  = 1000
innodb_io_capacity_max              = 4000
innodb_buffer_pool_size             = 4G
innodb_log_buffer_size              = 32M
innodb_autoinc_lock_mode            = 1
innodb_buffer_pool_load_at_startup  = ON
innodb_buffer_pool_dump_at_shutdown = ON
innodb_buffer_pool_dump_pct         = 15
innodb_max_dirty_pages_pct          = 85
innodb_lock_wait_timeout            = 10
#innodb_locks_unsafe_for_binlog     = 1
innodb_old_blocks_time              = 1000
innodb_open_files                   = 63000
innodb_page_cleaners                = 4
innodb_strict_mode                  = ON
innodb_thread_concurrency           = 24
innodb_sort_buffer_size             = 64M
innodb_print_all_deadlocks          = 1
innodb_rollback_on_timeout          = ON
#************** safe ***************
ssl-ca = /opt/mysql/ca-pem/ca.pem
ssl-cert = /opt/mysql/ca-pem/server-cert.pem
ssl-key = /opt/mysql/ca-pem/server-key.pem

[client]
socket                              = /data/mysql/mysql.sock
EOF

# 创建SSL证书
mkdir -p /opt/mysql/ca-pem/
/opt/mysql/bin/mysql_ssl_rsa_setup -d /opt/mysql/ca-pem/ --uid=mysql

cat >> /data/mysql/init_file.sql <<EOF
set global sql_safe_updates=0;
set global sql_select_limit=50000;
EOF

# 启动服务
/etc/init.d/mysqld start

# 修改初始密码
/opt/mysql/bin/mysqladmin -uroot -p${mysql_passwd} password 'iloveyou'

# 客户端环境变量
echo "export PATH=\$PATH:/opt/mysql/bin" | tee -a /etc/profile
source /etc/profile
