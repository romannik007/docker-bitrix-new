#!/bin/bash

usermod --uid $USER_ID bitrix
mkdir -p /tmp/php_sessions/www
mkdir -p /tmp/php_upload/www
chmod -R 777 /tmp/php_sessions
chmod -R 777 /tmp/php_upload
#chmod -R 777 /home/bitrix/www
rm -f /var/run/*.pid

#/etc/init.d/stunnel start
#/etc/init.d/bvat start
#mkdir /var/run/munin
#munin-node /etc/munin/munin-node.conf
rm -f /etc/httpd/run/*.pid
rm -f /run/httpd/*.pid
mkdir -p /var/run/httpd
mkdir -p /var/log/supervisor 
mkdir -p /var/log/crond
mkdir -p /var/log/httpd
mkdir -p /var/log/nginx
mkdir -p /var/log/samba
mkdir -p /var/log/xdebug
chmod -R 777 /var/log
mount -t cifs //$4/$5 /home/bitrix/www -o username=$1,password=$2,domain=$3,dir_mode=0777,file_mode=0777,sec=ntlmv2
eval `/opt/cprocsp/src/doxygen/CSP/../setenv.sh --64`
exec /usr/bin/supervisord #-c /etc/supervisor.d/supervisord.conf
