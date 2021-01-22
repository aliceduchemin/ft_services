#!/bin/sh

mysql_install_db -uroot --no-defaults --basedir=/usr --datadir=/var/lib/mysql
mysqld -u root & sleep 5

mysql -uroot --execute="CREATE DATABASE wordpress;"
mysql -uroot wordpress < wordpress.sql
mysql -uroot --execute="CREATE USER '$MYSQL_ROOT'@'%' IDENTIFIED BY '$MYSQL_PASS';"
mysql -uroot --execute="GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT'@'%' WITH GRANT OPTION;"
mysql -uroot --execute="USE wordpress; FLUSH PRIVILEGES;"

telegraf & sleep infinite
