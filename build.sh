#!/bin/bash
mysql_root_pass='admin'
chmod +x ./bitrix-env.sh
chmod +x ./mysql.sh
mkdir -m 777 -p ./bitrix/local
mkdir -m 777 -p ./bitrix/backup
mkdir -m 777 -p ./bitrix/mysql
mkdir -m 777 -p ./bitrix/www
docker build --no-cache -t  bitrix:new .
docker stop bitrix-new
docker rm bitrix-new
docker create --name bitrix-new --cap-add SYS_ADMIN --security-opt seccomp:unconfined --privileged \
              --hostname=bitrix \
              --tmpfs /tmp --tmpfs /run \
              --userns=host \
              -v /sys/fs/cgroup:/sys/fs/cgroup:ro  bitrix:new
docker start bitrix-new
#docker exec -ti bitrix-new sh -c "yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm;percona-release setup ps57;exit"
docker exec -ti bitrix-new sh -c "/root/bitrix-env.sh -p -H  bitrix -M $mysql_root_pass;/root/mysql.sh $mysql_root_pass;/root/menu.sh;bash"

#docker exec -ti bitrix-new sh -c "/root/mysql.sh $mysql_root_pass;"
#docker exec -ti bitrix-new sh -c "yum -y install bx-push-server;exit;"
#docker exec -ti bitrix-new sh -c "/opt/webdir/bin/menu/10_push/01_configure_push_service.sh;top"
#docker exec -ti bitrix-new sh -c "/etc/init.d/push-server-multi reset"
docker stop bitrix-new
