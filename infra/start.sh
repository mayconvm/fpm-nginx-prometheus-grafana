#!/bin/sh

# start fpm
php-fpm7

# start nginx
nginx

tail -f /var/log/php7/error.log \
		/var/log/nginx/error.log \
		/var/log/nginx/access.log \
		/var/log/php-fpm/slowlog-site.log