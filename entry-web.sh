#!/bin/bash

mkdir -p /tmp/php_sessions/www
mkdir -p /tmp/php_upload/www
chmod -R 777 /tmp/php_sessions
chmod -R 777 /tmp/php_upload
rm -f /run/nginx*.pid
/usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon on;"
#/etc/init.d/stunnel start
#/etc/init.d/bvat start
#mkdir /var/run/munin
#munin-node /etc/munin/munin-node.conf
rm -f /etc/httpd/run/*.pid
rm -f /run/httpd/*.pid
mkdir /var/run/httpd
/usr/sbin/crond
/usr/sbin/httpd
exec /usr/sbin/httpd -f /etc/httpd/conf/httpd-scale.conf -D FOREGROUND
#cron -n