#!/bin/bash

#docker start bitrix-new
#docker exec bitrix-new sh -c "yum -y clean all;exit"
docker stop bitrix-new
docker commit bitrix-new romannik/bitrix:bitrix-base-new7.4
docker push romannik/bitrix:bitrix-base-new7.4
echo "commit successful"
