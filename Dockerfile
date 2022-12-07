FROM php:8.1-fpm
USER root
RUN apt update && apt install -y unzip
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd bcmath ctype curl dom fileinfo iconv intl json mbstring openssl pcre pdo_mysql soap sockets sodium xmlwriter xsl zip
COPY ./php.ini /etc/php/8.1/cli/php.ini
COPY ./php.ini /etc/php/8.1/fpm/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./auth.json /root/.composer/auth.json
RUN composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html/magento
WORKDIR /var/www/html/magento
RUN find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
RUN find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
RUN chown -R :www-data . # Ubuntu
RUN chmod u+x bin/magento

RUN bin/magento setup:install \
    --base-url=http://127.0.0.1/magento/ \
    --db-host=127.20.0.3:3306 \
    --db-name=magento \
    --db-user=magento \
    --db-password=magento \
    --admin-firstname=guille \
    --admin-lastname=onestic \
    --admin-email=guillermo.ruiz@onestic.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=EUR \
    --timezone=Europe/Madrid \
    --use-rewrites=1 \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=localhost \
    --elasticsearch-port=9200 \
    --elasticsearch-index-prefix=magento2 \
    --elasticsearch-timeout=15
