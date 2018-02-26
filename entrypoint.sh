#!/bin/sh
nginx
php-fpm7
/usr/bin/supervisord -c /etc/supervisord.conf
