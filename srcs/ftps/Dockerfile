FROM alpine
RUN apk --no-cache add vsftpd openssl telegraf \
	&& mkdir -p /etc/ssl/private \
	&& chown -R root:root /etc/ssl/*

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/vsftpd.key \
	-out /etc/ssl/certs/vsftpd.crt \
	-subj "/C=FR/ST=Ile de France/L=Paris/O=42/CN=aduchemi"

ADD	./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
ADD	./srcs/setup.sh /
ADD	./srcs/telegraf.conf /etc/telegraf/

EXPOSE 21 30001

CMD	/bin/sh /setup.sh
