#!/bin/bash

/etc/init.d/push-server-multi reset
/etc/init.d/push-server-multi start
exec /usr/bin/redis-server /etc/redis.conf --daemonize no

