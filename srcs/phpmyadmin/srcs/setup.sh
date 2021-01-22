#!/bin/sh

telegraf &
/usr/sbin/php-fpm7 &
/usr/sbin/nginx -g 'daemon off;'
