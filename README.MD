# Laravel Docker Dev

This is a image for you to quickly start running a Laravel application in docker.

`Composer` comes with the image.

## Supported tags and respective Dockerfile links

- [`latest` (Dockerfile)](https://github.com/JonathanGuo/laravel-docker-dev/blob/master/Dockerfile) - PHP-FPM 7.2 alpine
- [`7.3` (Dockerfile)](https://github.com/JonathanGuo/laravel-docker-prod/blob/7.3/Dockerfile) - PHP-FPM 7.3 alpine
- [`7.2` (Dockerfile)](https://github.com/JonathanGuo/laravel-docker-prod/blob/7.2/Dockerfile) - PHP-FPM 7.2 alpine

### Deprecated
- [`1.0` (Dockerfile)](https://github.com/JonathanGuo/laravel-docker-dev/blob/1.0/Dockerfile) - PHP-FPM 7.0 alpine

## PHP Extensions

- [x] bcmath
- [x] curl
- [x] gettext
- [x] gd
- [x] exif
- [x] iconv
- [x] intl
- [x] ldap
- [x] mbstring
- [x] opcache
- [x] pdo_mysql
- [x] pdo_pgsql
- [x] pdo_dblib
- [x] soap
- [x] sockets
- [x] zip
- [x] grpc
- [x] memcached

## Environment variables

This image supports the environment variables below:

```
ENABLE_CRON_JOB: false
ENABLE_LARAVEL_WORKER: false
ENABLE_LARAVEL_HORIZON: false
```

## Volumes mount

`/app` - The directory the application should be mounted to

### A sample usage with docker-compose

docker-composer.yml


```yml
version: '3'
services:
  php:
    image: chcjonathanguo/laravel-docker-prod:latest
    volumes:
      - ./:/app:delegated
    ports:
      - '8000:80'
    volumes:
      - ~/.composer-docker/cache:/root/.composer/cache:delegated
      - ./:/app:delegated
  nginx:
    image: nginx:latest
    depends_on:
      - php
    volumes:
      - ./:/app:delegated
      - ./docker-config/dev/nginx/default.conf:/etc/nginx/conf.d/default.conf
```
