FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV PHP_VERSION="7.2"

RUN apt  update -y && \
    apt  install -y curl git apt-utils zip vim

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt install -y software-properties-common && add-apt-repository ppa:ondrej/php && apt update -y

RUN apt  install -y  \
    php${PHP_VERSION}  \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-xdebug \
    php${PHP_VERSION}-curl  \
    php${PHP_VERSION}-mbstring  \
    php${PHP_VERSION}-json  \
    php${PHP_VERSION}-xml

RUN echo "xdebug.mode=debug,coverage" >> /etc/php/${PHP_VERSION}/cli/php.ini

WORKDIR /var/php-saml
