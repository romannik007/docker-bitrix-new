#!/bin/bash

mkdir -p /tmp/php_sessions/www
mkdir -p /tmp/php_upload/www
chmod -R 777 /tmp/php_sessions
chmod -R 777 /tmp/php_upload
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
exec /usr/bin/supervisord #-c /etc/supervisor.d/supervisord.conf
