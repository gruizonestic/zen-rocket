FROM php:8.1-fpm
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd bcmath ctype curl dom fileinfo iconv intl json mbstring openssl pcre pdo_mysql soap sockets sodium xmlwriter xsl zip
COPY ./php.ini /usr/local/etc/php/conf.d/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ADD ./auth.json /root/.composer/auth.json
RUN composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html
COPY ./install-magento.sh /usr/src/
RUN chmod +x /usr/src/install-magento.sh
COPY auth.json /var/www/html/var/composer_home/

