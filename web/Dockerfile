FROM php:5.6-apache

#RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = Asia/Tokyo|" /etc/php.ini

COPY ./php.ini /usr/local/etc/php/

#COPY ./httpd.conf /etc/httpd/conf.d/yourgreatapp.conf

RUN apt-get update && apt-get install -y \
  libpq-dev \
  libmemcached-dev \
  curl \
  mysql-client \
  postgresql-client \
  libpng12-dev \
  libfreetype6-dev \
  libssl-dev \
  libmcrypt-dev \
  --no-install-recommends && \
  rm -r /var/lib/apt/lists/*

RUN apt-get update && \
  docker-php-ext-install pdo_mysql mysqli mbstring

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]