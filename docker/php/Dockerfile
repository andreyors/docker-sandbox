FROM php:7.1.0-fpm-alpine

ENV TIMEZONE UTC
ENV PHP_MEMORY_LIMIT 512M
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

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
#    && sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/php.ini \
#    && sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php/php.ini \
#    && sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php/php.ini \
#    && sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php/php.ini \
#    && sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php/php.ini \
#    && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/php.ini
