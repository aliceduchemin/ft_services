FROM alpine

RUN	apk update && apk add influxdb telegraf

ADD	./srcs/setup.sh /
ADD	./srcs/telegraf.conf /etc/telegraf/

EXPOSE 8086

CMD /bin/sh /setup.sh
