#!/bin/bash

/etc/init.d/push-server-multi reset
/etc/init.d/push-server-multi start
/usr/bin/redis-server /etc/redis.conf --daemonize no

