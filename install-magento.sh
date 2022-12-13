#!/bin/bash
cd /var/www/html
bin/magento setup:install \
    --base-url=http://127.0.0.1/ \
    --db-host=mysql \
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
    --elasticsearch-host=elastic \
    --elasticsearch-port=9200 \
    --elasticsearch-index-prefix=magento2 \
    --elasticsearch-timeout=15 \
    --amqp-host="rabbit" \
    --amqp-port="5672" \
    --amqp-user="magento" \
    --amqp-password="magento" \
    --amqp-virtualhost="/" \
    --cache-backend=redis \
    --cache-backend-redis-server=redis \
    --cache-backend-redis-db=0

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R :www-data .
chmod u+x bin/magento
cp /root/.composer/auth.json /var/www/html/var/composer_home/
bin/magento sampledata:deploy
bin/magento setup:upgrade
