ARG PHP=${PHP}
FROM romannik/bitrix:bitrix-base-new${PHP}
RUN yum install -y epel-release \
    supervisor cifs-utils samba-client samba vsftpd \
    php-devel php-gd php-pecl-redis && \
    pecl install xdebug
    
COPY ./bitrix/nginx-config/rtc-server.conf /etc/nginx/bx/site_enabled/rtc-server.conf
#echo rtc-server.conf
COPY ./bitrix/nginx-config/rtc-im_settings.conf /etc/nginx/bx/settings/rtc-im_settings.conf
##echo rtc-im_settings.conf
COPY ./bitrix/push-config/redis.conf /etc/redis/redis.conf
#echo redis.conf
COPY ./bitrix/nginx-config/rtc-im_subscrider.conf /etc/nginx/bx/conf/rtc-im_subscrider.conf
#echo rtc-im_subscrider.conf
COPY ./bitrix/push-config/push-server-multi /etc/sysconfig/push-server-multi
COPY ./bitrix/php/php.d/z_bx_custom.ini /etc/php.d/z_bx_custom.ini
COPY ./bitrix/php/php.d/10-opcache.ini /etc/php.d/10-opcache.ini
COPY ./bitrix/nginx-config/z_bx_custom.conf /etc/nginx/bx/settings/z_bx_custom.conf
COPY ./bitrix/nginx-config/http-add_header.conf  /etc/nginx/bx/conf/http-add_header.conf 
COPY ./bitrix/apache/z_bx_custom.conf /etc/httpd/bx/custom/z_bx_custom.conf
COPY ./bitrix/cron/bitrix /etc/cron.d/bitrix
COPY entry-push.sh /root/entry-push.sh
COPY entry-web.sh /root/entry-web.sh
RUN chmod +x /root/entry-web.sh /root/entry-push.sh /usr/lib64/php/modules/xdebug.so
#COPY ./fs/smb/smb.conf /etc/samba
EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp 20-21/tcp
EXPOSE 8010-8015/tcp 9010-9011/tcp 8893-8895/tcp
#COPY ./bitrix/cron/bitrix /var/spool/cron/crontabs/bitrix

#echo push-server-multi
