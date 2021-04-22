#!/bin/bash

#systemctl disable --now mysql
#systemctl disable --now httpd
#systemctl disable --now httpd-scale
#systemctl disable --now nginx

/etc/init.d/push-server-multi reset
/etc/init.d/push-server-multi start
/usr/bin/redis-server /etc/redis.conf --daemonize no



