#!/bin/bash
mysql_root_pass='admin'
mkdir -m 777 -p ./bitrix/app
mkdir -m 777 -p ./bitrix/backup
mkdir -m 777 -p ./bitrix/mysql
mkdir -m 777 -p ./bitrix/www
docker build -t  bitrix:1 .
docker stop bitrix-new
docker rm bitrix-new
docker create --name bitrix-new --cap-add SYS_ADMIN --security-opt seccomp:unconfined --privileged \
              --hostname=bitrix \
              --tmpfs /tmp --tmpfs /run \
              -v /sys/fs/cgroup:/sys/fs/cgroup:ro  bitrix:1
docker start bitrix-new
#docker exec -ti bitrix-new sh -c "yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm;percona-release setup ps57;exit"
docker exec -ti bitrix-new sh -c "/root/bitrix-env.sh -p -H  bitrix -M $mysql_root_pass;/root/mysql.sh $mysql_root_pass;/root/menu.sh;bash"
docker stop bitrix-new
