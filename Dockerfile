FROM ubuntu:18.04

LABEL maintainer="Pedro Resende <pedroresende@mail.resende.biz>"

ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -my \
  curl \
  wget \
  php-curl \
  php-fpm \
  php-gd \
  php-xsl \
  php-mysqlnd \
  php-cli \
  php-intl \
  php-bz2 \
  php-zip \
  php-xdebug \
  php-mbstring \
  git \
  zip \
  php-apcu \
  php-opcache

RUN mkdir /run/php

ADD conf/www.conf /etc/php/7.2/fpm/pool.d/www.conf
ADD conf/memory.ini /etc/php/7.2/fpm/conf.d/memory.ini
ADD conf/upload_max_filesize.ini /etc/php/7.2/fpm/conf.d/upload_max_filesize.ini
ADD conf/opcache.ini /etc/php/7.2/mods-available/10-opcache.ini
ADD conf/apcu.ini /etc/php/7.2/mods-available/20-apcu.ini
ADD conf/apcu.ini /etc/php/7.2/mods-available/20-apcu_bc.ini
ADD conf/php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf

RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && chmod +x /usr/local/bin/composer

EXPOSE 9000

CMD ["php-fpm7.2"]
