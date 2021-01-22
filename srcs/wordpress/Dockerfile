FROM alpine

RUN	apk update && apk add wget nginx telegraf \
	&& apk add php7 php7-fpm php7-opcache \
	&& apk add php7-gd php7-mysqli php7-zlib php7-curl \
	&& apk add php7 php7-common php7-session php7-iconv php7-xml php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-fpm php7-cli php7-json php7-mbstring php7-opcache

RUN chmod -R 755 /var/* \
	&& chown -R nginx:nginx /var/lib/nginx/* && mkdir -p /run/nginx

RUN	wget -c http://wordpress.org/latest.tar.gz
RUN	tar -xzvf latest.tar.gz \
	&& mv wordpress/* /var/lib/nginx/html/ \
	&& rm /var/lib/nginx/html/wp-config-sample.php \
	&& rm /etc/nginx/conf.d/default.conf

ADD	./srcs/telegraf.conf /etc/telegraf/
ADD	./srcs/wp-config.php /var/lib/nginx/html
ADD	./srcs/my_ng.conf /etc/nginx/conf.d/
ADD	./srcs/setup.sh /

EXPOSE 5050

CMD /bin/sh /setup.sh
