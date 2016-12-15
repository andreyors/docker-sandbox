FROM php:7.1.0-fpm-alpine

ENV TIMEZONE UTC

RUN \
    { set -x ;} 2> /dev/null \
    && apk update \
	&& apk add --update tzdata \
	&& cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
	&& echo "${TIMEZONE}" > /etc/timezone \
    && apk add --no-cache \
        ca-certificates curl \
        freetype libpng libjpeg-turbo \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        libmcrypt libmcrypt-dev \
        go bzr \
        git \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} \
        gd \
        pdo_mysql \
        mysqli \
        opcache \
        mcrypt \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require "hirak/prestissimo:^0.3" \
    && GOPATH=/tmp/gocode go get github.com/mailhog/mhsendmail \
    && mv /tmp/gocode/bin/mhsendmail /usr/local/bin/mhsendmail \
    && apk del --no-cache \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        libmcrypt-dev \
        tzdata \
        go bzr \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && set -e

