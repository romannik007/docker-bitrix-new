ARG PHP
FROM romannik/bitrix:bitrix-base-new${PHP}
ARG PHP
RUN yum install -y epel-release  \
    supervisor cifs-utils samba-client samba vsftpd \
    php-devel php-gd php-pecl-redis \
    wget lsb boost-devel boost sqlite-devel && \
    yum group install -y "Development Tools" php-xdebug
COPY bitrix/cryptopro/linux-amd64 /linux-amd64
RUN cd /linux-amd64 && \
    ./install.sh && \
    yum install -y lsb-cprocsp-devel* \
        cprocsp-pki-cades* \
        cprocsp-pki-phpcades* \
        cprocsp-legacy-*

#add php_CPCSP
RUN wget --no-check-certificate https://www.php.net/distributions/php-7.4.29.tar.gz -O /php.tar.gz && \
    tar xvzf /php.tar.gz && \
    cd /php-7.4.29 && \
    ./configure --prefix=/opt/php

COPY bitrix/cryptopro/php7_support.patch/php7_support.patch /opt/cprocsp/src/phpcades/php7_support.patch

RUN sed -i "s/PHPDIR=\/php/PHPDIR=\/php-7.4.29/g" /opt/cprocsp/src/phpcades/Makefile.unix && \
    sed -i 's!-fPIC -DPIC!-fPIC -DPIC -fpermissive!1' /opt/cprocsp/src/phpcades/Makefile.unix && \
    cd /opt/cprocsp/src/phpcades && \
    patch -p0 < ./php7_support.patch && \
    cd /opt/cprocsp/src/phpcades && eval `/opt/cprocsp/src/doxygen/CSP/../setenv.sh --64`; make -f Makefile.unix && \
    ln -s /opt/cprocsp/src/phpcades/libphpcades.so /usr/lib64/php/modules/libphpcades.so;\
    ldconfig

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





