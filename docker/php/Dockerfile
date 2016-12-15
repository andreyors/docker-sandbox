FROM php:7.1.0-fpm-alpine



RUN \
    apk update \
	&& apk add --update tzdata \
	&& cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
	&& echo "${TIMEZONE}" > /etc/timezone \
    && apk add --no-cache \
        ca-certificates curl \
        freetype libpng libjpeg-turbo \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        libmcrypt libmcrypt-dev \
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
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && composer global require "hirak/prestissimo:^0.3" \
    && apk del --no-cache \
        freetype-dev libpng-dev libjpeg-turbo-dev \
        libmcrypt-dev \
        tzdata \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man
