# Dockerización de magento 🐋.
Nuestro cliente ficticio ACME, SA nos ha pedido que dockerizemos el entorno de trabajo para su equipo de desarrollo de magento.

## Requisitos de magento.
- Elasticsearch 7.17 
- MySQL 8.0 
- PHP 8.1 / PHP-fpm
- RabbitMQ 3.9 
- Redis 6.2 
- Nginx 1.18 
- Composer 2.2 

> Varnish y ProxySQL no se van a tener en cuenta para la realización del ejercicio.

## Requisitos del sistema.
- Docker. 
- Docker compose.

> [Cómo instalar Docker](https://docs.docker.com/get-docker/)

- Se va a levantar un contenedor por cada servicio que necesita Magento para funcionar.
- Las imágenes de estos contenedores son imágenes oficiales lo más optimizadas posibles. 
- Para la instalación de magento se utilizará la herramienta *composer* y se hará la instalación en local.

## Antes de empezar...

Clonar el repositorio en un directorio local.
```sh
git clone https://github.com/gruizonestic/zen-rocket.git
```
Navegar al directorio zen-rocket
```sh
cd zen-rocket
```
Poner en marcha los contenedores 
```sh
docker compose up -d 
```

## Prerequisitos de instalación.
Siguiendo la [guía de instalación de Adobe Commerce / Magento Open Source](https://experienceleague.adobe.com/docs/commerce-operations/installation-guide/prerequisites/overview.html?lang=en), vamos a comprobar los siguientes ítems: sistema de ficheros, web server, base de datos, php, cola de mensajería y otros.

### MySQL

Comprobamos que tenemos acceso a la BD del contenedor ejecutando:
```sh
mysql -P 3306 -u magento --protocol=tcp -p
```
La contraseña es: magento

### Elasticsearch

Comprobamos que elastic está funcionando ejecutando:
```sh
curl -XGET 'localhost:9200'
```
Nos devuelve un JSON con los parámetros del clúster (de una única máquina). 

### Sistema de ficheros.

## Instalación local de PHP.

Instalar PHP 8.1, PHP-fpm y todos los módulos que necesita magento.
```sh
sudo apt install php php-fpm php8.1-bcmath php8.1-curl php8.1-xml php8.1-gd php8.1-intl php8.1-mbstring php8.1-mysql php8.1-soap php8.1-zip
```

Editamos los dos ficheros de configuración de php y php-fpm con la misma configuración:
```sh
sudo vim /etc/php/8.1/cli/php.ini
```
```sh
sudo vim /etc/php/8.1/fpm/php.ini
```
Configuramos los siguientes parámetros:
```sh
date.timezone = "Europe/Madrid"
memory_limit = 2G
realpath_cache_size=10M
realpath_cache_ttl=7200
max_execution_time = 1800
zlib.output_compression = On
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.save_comments=1
```
Reiniciamos el servicio de php-fpm
```sh
systemctl restart php8.1-fpm
```

## Instalación local de composer.

Para instalar composer abrimos una terminal, navegamos al directorio de instalación que queramos y ejecutamos los siguientes comandos.
```sh
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
```
```sh
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
```
```sh
php composer-setup.php
```
```sh
php -r "unlink('composer-setup.php');"
```
Opcionalmente, movemos el ejecutable a ```/usr/local/bin/composer ``` y así lo tendremos disponible en el PATH para poder llamarlo desde cualquier directorio.

```sh
sudo mv composer.phar /usr/local/bin/composer
```

## Instalación local de magento base.

Abrimos una terminal y ejecutamos:
```sh
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /ruta/donde/queremos/instalar/magento 
```
> Nos pedirá usuario y contraseña para instalar magento. 

Especificamos los permisos necesarios para que magento pueda escribir en el sistema de ficheros. 

cd /var/www/html/<ruta donde hemos instalado magento>


