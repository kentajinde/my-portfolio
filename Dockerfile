FROM    php:7.2-apache
RUN     usermod -u 1000 www-data \
    &&  groupmod -g 1000 www-data \
    &&  a2enmod rewrite \
    &&  pecl install xdebug-2.6.0 \
    &&  apt-get update -y \
    &&  apt-get install -y zlib1g-dev \
    &&  docker-php-ext-enable xdebug \
    &&  docker-php-ext-install pdo_mysql mysqli mbstring zip \
    &&  apt-get clean
COPY    --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY    . .
VOLUME  ${pwd}:"/var/www/html"
CMD     ["./startup.sh"]