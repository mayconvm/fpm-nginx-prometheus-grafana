FROM alpine:latest

# Install dependences
RUN apk update && apk upgrade
RUN apk add nginx php7 php7-fpm
RUN apk add php7-gd php7-mysqli php7-zlib php7-curl php7-opcache
RUN apk add tzdata

RUN TIMEZONE="America/Sao_Paulo" && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo "${TIMEZONE}" > /etc/timezone && sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini

# configure nginx
RUN adduser -D -g 'www' www
RUN mkdir -p /app /run/nginx/ /var/log/php-fpm/ && chown -R www:www /var/lib/nginx && chown -R www:www /app

ADD infra/nginx.conf /etc/nginx/nginx.conf

# configure fpm

ADD infra/fpm.conf /etc/php7/php-fpm.conf
ADD infra/php.ini /etc/php7/php.ini

# run 
ADD infra/start.sh /start.sh

WORKDIR /app
ENTRYPOINT /start.sh
