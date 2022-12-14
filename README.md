# Dockerizaci贸n de magento 馃悑.
Nuestro cliente ficticio ACME, SA nos ha pedido que dockerizemos el entorno de trabajo para su equipo de desarrollo de magento.

## Requisitos de magento.
- Elasticsearch 7.17 
- MySQL 8.0 
- PHP 8.1 / PHP-fpm
- RabbitMQ 3.9 
- Redis 6.2 
- Nginx 1.18 
- Composer 2.2 

> Varnish y ProxySQL no se van a tener en cuenta para la realizaci贸n del ejercicio.

## Requisitos del sistema.
- Docker. 
- Docker compose.

> [C贸mo instalar Docker](https://docs.docker.com/get-docker/)

- Se va a levantar un contenedor por cada servicio que necesita Magento para funcionar.
- Las im谩genes de estos contenedores son im谩genes oficiales lo m谩s optimizadas posibles. 

## Ejecuci贸n de los contenedores

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
## Instalaci贸n de magento
*Importante:* copia el fichero *auth.json* en el directorio del proyecto. <br> 
Accedemos al contenedor de php-fpm ejecutando desde un terminal
```sh
docker exec -it php bash
```
Y una vez dentro, lanzamos el script de instalaci贸n de magento con el sample data.
```sh
/usr/src/install-magento.sh
```

## Post-instalaci贸n

Accede a http://localhost y comprueba que ves la p谩gina por defecto de LUMA.

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
Usuario y contrase帽a: *magento*