#!/bin/bash
chmod +x ./entry-web.sh.sh

docker start bitrix-new
chmod +x ./entry-web.sh
chmod +x ./entry-mysql.sh
docker cp ./entry-web.sh bitrix-new:/root/
docker cp ./entry-mysql.sh bitrix-new:/root/
docker exec -d bitrix-new sh -c "mkdir /opt/push-server/logs;exit"
docker exec -d bitrix-new sh -c "mkdir /var/run/mysqld;exit"
docker exec -d bitrix-new sh -c "yum -y clean all;exit"
docker stop bitrix-new
docker commit bitrix-new romannik/bitrix:bitrix-base-new
echo "commit successful"
