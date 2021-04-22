#!/bin/bash


mkdir -p /opt/push-server/logs
exec /usr/bin/supervisord # -c /etc/supervisor.d/supervisord.conf
