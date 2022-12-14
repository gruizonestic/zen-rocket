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

## Ejecución de los contenedores

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
## Instalación de magento
*Importante:* copia el fichero *auth.json* en el directorio del proyecto. <br> 
Accedemos al contenedor de php-fpm ejecutando desde un terminal
```sh
docker exec -it php bash
```
Y una vez dentro, lanzamos el script de instalación de magento con el sample data.
```sh
/usr/src/install-magento.sh
```

## Post-instalación

Accede a http://localhost y comprueba que ves la página por defecto de LUMA.

## Comprobar logs

Logs de nginx
```sh
docker logs nginx -f
```
Logs de php-fpm
```sh
docker logs php -f
```
Logs de elasticsearch
```sh
docker logs elastic -f
```
Logs de redis
```sh
docker logs redis -f
```
Acceder al panel de control de RabbitMQ
```sh
http://localhost:15672
```
Usuario y contraseña: *magento*