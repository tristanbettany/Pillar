FROM php:8.0-fpm

ARG DEBIAN_FRONTEND=noninteractive

# Install Libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget zip unzip vim openssl \
    libgd3 libgd-dev libwebp-dev libpq-dev libmagickwand-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev \
    nghttp2 libhiredis-dev libmemcached-dev pkg-config zlib1g-dev librdkafka-dev libtidy-dev libmcrypt-dev && \
    apt-get -y autoremove && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Pear Extensions
RUN wget http://pear.php.net/go-pear.phar && \
    php go-pear.phar
RUN pecl channel-update pecl.php.net
RUN pecl install xdebug mcrypt memcached rdkafka imagick
RUN docker-php-ext-enable xdebug mcrypt memcached imagick opcache sodium rdkafka

# Install GD
RUN docker-php-ext-configure gd --with-webp --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

# Install PHP Extensions not installed by default \
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql zip bcmath intl tidy opcache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Config
ADD ./config/php.ini /usr/local/etc/php/conf.d/php.ini
ADD ./config/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf