#!/bin/bash
echo "[mysqld]"
echo "[mysqld]" >> /etc/mysql/conf.d/z_bx_custom.cnf
echo ";" >> /etc/httpd/bx/custom/z_bx_custom.conf
echo "ServerName localhost" >> /etc/httpd/bx/custom/z_bx_custom.conf
echo "bind-address=0.0.0.0"
echo "bind-address=0.0.0.0" >> /etc/mysql/conf.d/z_bx_custom.cnf
echo "log-error=mysql.err" >> /etc/mysql/conf.d/z_bx_custom.cnf
echo $1
mysql -u root -p$1 -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$1' WITH GRANT OPTION;"
mysql -u root -p$1 -e "FLUSH PRIVILEGES;"
echo