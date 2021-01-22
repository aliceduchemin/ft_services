FROM alpine

RUN	apk update && apk add wget nginx telegraf \
	&& apk add php7-gd php7-mysqli php7-zlib php7-curl \
	&& apk add mysql mysql-client --no-cache \
	&& apk add php7 php7-session php7-common php7-iconv php7-xml php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-fpm php7-cli php7-json php7-mbstring php7-opcache

RUN chmod -R 755 /var/* \
	&& chown -R nginx:nginx /var/lib/nginx/* && mkdir -p /run/nginx

RUN	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages/* /var/lib/nginx/html \
	&& mkdir /run/php-fpm7

RUN	rm /var/lib/nginx/html/config.sample.inc.php \
	&& mkdir /var/lib/nginx/html/tmp \
	&& chmod -R 777 /var/lib/nginx/html/tmp \
	&& rm /etc/nginx/conf.d/default.conf
ADD	./srcs/config.inc.php /var/lib/nginx/html/
ADD	./srcs/my_ng.conf /etc/nginx/conf.d/
ADD	./srcs/telegraf.conf /etc/telegraf/
ADD	./srcs/setup.sh /

EXPOSE 5000

CMD	/bin/sh /setup.sh
