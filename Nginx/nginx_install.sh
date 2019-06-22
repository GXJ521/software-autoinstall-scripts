#!/bin/bash


. /etc/init.d/functions
User=`whoami`

Nginx_Install () {
    echo '*-----安装Nginx-----*'
    sudo mkdir -p /var/log/nginx/ && sudo chown -R ${User}.${User} /var/log/nginx
    sudo mkdir -p /var/run/nginx/ && sudo chown -R ${User}.${User} /var/run/nginx/
    sudo mkdir -p /var/cache/nginx/ && sudo chown -R ${User}.${User} /var/cache/nginx/
    sudo mkdir -p /etc/nginx/ && sudo chown -R ${User}.${User} /etc/nginx/
    sudo mkdir -p /usr/share/nginx/html/ && sudo chown -R ${User}.${User} /usr/share/nginx/html/
    sudo sed -i "s#create 640 nginx adm#create 640 ${User} ${User}#g" /etc/logrotate.d/nginx
    sudo \cp nginx.conf /etc/nginx/nginx.conf
    sudo \cp proxy.conf /etc/nginx/conf.d/proxy.conf
}

Nginx_Install
