FROM debian:trixie

ARG DEBIAN_FRONTEND=noninteractive

ENV DISTRO_CODENAME="trixie"
ENV PHP_VERSION="8.3"

RUN apt  update -y && \
    apt  install -y lsb-release ca-certificates curl git apt-utils vim \
    gettext openssl mcrypt gnupg2 apt-utils git locales

# For PHP installation when using Debian
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-php.gpg && \
    echo "deb https://packages.sury.org/php/ ${DISTRO_CODENAME} main" \
      | tee /etc/apt/sources.list.d/sury-php.list && \
    apt update -y

RUN apt  install -y  \
    php${PHP_VERSION}  \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-xdebug \
    php${PHP_VERSION}-curl  \
    php${PHP_VERSION}-mbstring  \
    php${PHP_VERSION}-xml  \
    php${PHP_VERSION}-zip

RUN echo "xdebug.mode=debug,coverage" >> /etc/php/${PHP_VERSION}/cli/php.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/php-saml
