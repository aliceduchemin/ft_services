#!/bin/sh

telegraf &
/usr/sbin/nginx -g 'daemon off;'
tail -f /dev/null
