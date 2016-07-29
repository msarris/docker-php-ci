FROM php:7.0-cli

ENV COMPOSER_HOME /root/composer

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libbz2-dev \
        libssh2-1-dev \
        libssh2-1 \
        php-pear \
        curl \
        git \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    	gd \
    	zip \
    	bz2 \
    	mbstring \
    	pdo_mysql \
    && yes '' | pecl install ssh2-1.0 \
    && echo extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/ssh2.so > /usr/local/etc/php/conf.d/docker-php-ext-ssh2.ini \
    && echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini \
    && echo "date.timezone = Europe/Amsterdam" > /usr/local/etc/php/conf.d/datetimezone.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/*

CMD ["php"]