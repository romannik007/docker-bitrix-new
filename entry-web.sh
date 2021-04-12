#!/bin/bash
#redis-server /etc/redis.conf
#mkdir /var/run/mysqld
#mkdir /opt/push-server/logs
#chown -R mysql:mysql /var/run/mysqld
#mysqld --daemonize
#/usr/bin/redis-server /etc/redis.conf --daemonize yes
#node /opt/push-server/server.js --config /opt/push-server/config/config-docker.json
#/etc/init.d/push-server-multi start
chmod -R /home/bitrix/www
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
/usr/sbin/httpd -f /etc/httpd/conf/httpd-scale.conf -D FOREGROUND
#cron -n