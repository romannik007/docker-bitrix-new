#!/bin/bash

chmod +x ./entry-web.sh
chmod +x ./entry-mysql.sh
docker start bitrix-new
docker cp ./entry-web.sh bitrix-new:/root/
docker cp ./entry-mysql.sh bitrix-new:/root/
docker exec -d bitrix-new mkdir /opt/push-server/logs
docker exec -d bitrix-new yum -y clean all
docker stop bitrix-new
docker commit bitrix-new romannik/bitrix:bitrix-base-new
docker push romannik/bitrix:bitrix-base-new
echo "commit successful"
