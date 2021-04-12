#!/bin/bash
chmod +x ./entry-web.sh
chmod +x ./entry-mysql.sh
chmod +x ./entry-push.sh
docker start bitrix-new
docker cp ./entry-web.sh bitrix-new:/root/
docker cp ./entry-mysql.sh bitrix-new:/root/
docker cp ./entry-push.sh bitrix-new:/root/
docker cp ./bitrix/nginx-config/rtc-server.conf bitrix-new:/etc/nginx/bx/site_enabled/rtc-server.conf
echo rtc-server.conf
docker cp ./bitrix/nginx-config/rtc-im_settings.conf bitrix-new:/etc/nginx/bx/settings/rtc-im_settings.conf
echo rtc-im_settings.conf
docker cp ./bitrix/push-config/redis.conf bitrix-new:/etc/redis/redis.conf
echo redis.conf
docker cp ./bitrix/nginx-config/rtc-im_subscrider.conf bitrix-new:/etc/nginx/bx/conf/rtc-im_subscrider.conf
echo rtc-im_subscrider.conf
docker cp ./bitrix/push-config/push-server-multi bitrix-new:/etc/sysconfig/push-server-multi
echo push-server-multi
docker exec bitrix-new sh -c "/etc/init.d/push-server-multi reset;exit"
#docker exec bitrix-new sh -c "systemctl enable push-server;exit"
#docker exec bitrix-new sh -c "systemctl disable --now mysqld;exit"
#docker exec bitrix-new sh -c "systemctl disable --now httpd;exit"
#docker exec bitrix-new sh -c "systemctl disable --now httpd-scale;exit"
docker exec bitrix-new sh -c "mkdir -p /opt/push-server/logs;exit"
docker exec bitrix-new sh -c "yum -y clean all;exit"
docker stop bitrix-new
docker commit bitrix-new romannik/bitrix:bitrix-base-new
docker push romannik/bitrix:bitrix-base-new
echo "commit successful"
