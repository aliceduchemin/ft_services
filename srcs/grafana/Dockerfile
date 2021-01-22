FROM alpine

RUN	apk update && apk add grafana telegraf

ADD	./srcs/telegraf.conf /etc/telegraf/
ADD	./srcs/setup.sh /

RUN	mkdir -p /usr/share/grafana/data
ADD	./srcs/grafana.db /usr/share/grafana/data

WORKDIR	/usr/share/grafana

EXPOSE 3000

CMD /bin/sh /setup.sh
