FROM php:7.2-fpm-alpine
LABEL maintainer="jonathan <chc.jonathan.guo@outlook.com>"

WORKDIR /app

COPY config /tmp/config

# Install system packages
RUN apk update && \
    apk add --no-cache \
        bash \
        git \
        freetds \
        freetype \
        icu \
        libintl \
        libldap \
        libjpeg \
        libpng \
        libpq \
        libwebp \
        libmemcached \
        composer \
        supervisor && \
    apk add --no-cache --virtual build-dependencies \
        curl-dev \
        freetds-dev \
        freetype-dev \
        gettext-dev \
        icu-dev \
        jpeg-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libmemcached-dev \
        openldap-dev \
        postgresql-dev \
        zlib-dev \
        autoconf \
        build-base && \
# Install PHP extensions
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure ldap --with-libdir=lib/ && \
    docker-php-ext-configure pdo_dblib --with-libdir=lib/ && \
    docker-php-ext-install \
        bcmath \
        curl \
        gettext \
        gd \
        exif \
        iconv \
        intl \
        ldap \
        mbstring \
        opcache \
        pdo_mysql \
        pdo_pgsql \
        pdo_dblib \
        soap \
        sockets \
        zip && \
# Install PECL extensions
    pecl install grpc memcached && \
    docker-php-ext-enable grpc memcached && \
    apk del build-dependencies && \
# Download trusted certs
    mkdir -p /etc/ssl/certs && update-ca-certificates && \
# Copy php configuration
    cp /tmp/config/php.ini /usr/local/etc/php/php.ini && \
# Copy supervisor config
    mkdir /etc/supervisor.d && \
    cp /tmp/config/supervisord.conf /etc/supervisord.conf && \
    cp -r /tmp/config/supervisor.d /etc && \
# Copy cron job
    cp /tmp/config/crontab /etc/crontabs/root && \
    cp /tmp/config/entrypoint.sh /entrypoint.sh && \
    rm -rf /tmp/config && \
    chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
