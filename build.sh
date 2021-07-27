#!/bin/bash
mysql_root_pass='admin'
mkdir -m 777 -p ./bitrix/app
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
#docker exec -ti bitrix-new sh -c "echo "proxy=http://192.168.99.142:3142" >> /etc/yum.conf" 
#docker exec -ti bitrix-new sh -c "echo "proxy=http://192.168.99.142:3142" >> ~/.wgetrc"
# via https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=32&LESSON_ID=20428&LESSON_PATH=3903.4862.8809.20428#recommended
#docker exec -ti bitrix-new sh -c "yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm;percona-release setup ps57;exit"
docker exec -ti bitrix-new sh -c "/root/bitrix-env.sh -p -H  bitrix -M $mysql_root_pass"
#;/root/mysql.sh $mysql_root_pass;/root/menu.sh;bash
# создание пула
docker exec -ti bitrix-new sh -c "/opt/webdir/bin/wrapper_ansible_conf -a create -H bitrix -I eth0"
# настройка пуш-сервера
docker exec -ti bitrix-new sh -c "/opt/webdir/bin/bx-sites -a push_configure_nodejs -H bitrix"
# настройка memcached сервиса
docker exec -ti bitrix-new sh -c "/opt/webdir/bin/bx-mc -a create -s bitrix; yum -y clean all; bash"

docker stop bitrix-new
