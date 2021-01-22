FROM alpine

RUN	apk update \
	&& apk add mysql mysql-client --no-cache telegraf

RUN chmod -R 755 /var/* \
	&& mkdir -p /var/log/mysql && chown -R root:root /var/log/mysql \
	&& chown -R root:root /var/lib/mysql
RUN	mkdir -p /run/mysqld && chmod -R 755 /run/mysqld && chown -R root:root /run/mysqld

ADD	./srcs/my.cnf /etc/mysql/my.cnf
ADD	./srcs/setup.sh /
ADD	./srcs/telegraf.conf /etc/telegraf/

ENV	MYSQL_ROOT	'administrateur'
ENV	MYSQL_PASS	'pass_administrateur'

EXPOSE 3306
CMD	/bin/sh /setup.sh
