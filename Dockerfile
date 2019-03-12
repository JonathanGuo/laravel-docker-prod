FROM chcjonathanguo/laravel-docker-prod:7.3
LABEL maintainer="jonathan <chc.jonathan.guo@outlook.com>"

# Install system packages
RUN apk add --no-cache \
        nodejs \
        npm \
        yarn
