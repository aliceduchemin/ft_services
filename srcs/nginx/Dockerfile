FROM alpine

RUN	apk update && apk add wget nginx openssl telegraf

RUN chmod -R 755 /var/* \
	&& chown -R nginx:nginx /var/lib/nginx/*  \
	&& chown -R nginx:nginx /etc/nginx/* && mkdir -p /etc/nginx/ssl \
	&& mkdir -p /run/nginx \
	&& rm /etc/nginx/conf.d/default.conf \
	&& rm /etc/ssl/certs/ca-certificates.crt

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-subj "/C=FR/ST=Ile de France/L=Paris/O=42/CN=aduchemi"

ADD	./srcs/telegraf.conf /etc/telegraf/

ADD	./srcs/my_ng.conf /etc/nginx/conf.d/default.conf
ADD	./srcs/index.html /var/lib/nginx/html/
ADD	./srcs/setup.sh /
EXPOSE 80 443

CMD /bin/sh /setup.sh
