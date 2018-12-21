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
        composer && \
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
    cp /tmp/config/php.ini /usr/local/etc/php/php.ini && \
    cp /tmp/config/entrypoint.sh /entrypoint.sh && \
    rm -rf /tmp/config && \
    chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
