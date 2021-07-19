#!/bin/bash


mkdir -p /opt/push-server/logs
chmod -R 777 /opt/push-server/logs
mkdir /var/log/supervisor
chmod -R 777 /var/log/supervisor
mkdir /var/log/redis
chmod -R 777 /var/log/redis
rm -f /var/log/*.pid

exec /usr/bin/supervisord # -c /etc/supervisor.d/supervisord.conf
