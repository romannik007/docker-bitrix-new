FROM centos:7
     ADD bitrix-env.sh /root/bitrix-env.sh
     ADD mysql.sh /root/mysql.sh
     ADD bitrix-env.sh /root/bitrix-env.sh
     RUN chmod +x /root/bitrix-env.sh
     RUN chmod +x /root/mysql.sh
     RUN yum -y install mc
     RUN yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
     RUN percona-release setup ps57
     RUN yum -y clean all
     EXPOSE 80
     EXPOSE 443
     EXPOSE 3306
     CMD ["/usr/sbin/init"]
