
## Visualizacion del tutorial
~~~
docker run -d -p 8081:80 docker/getting-started
~~~
_Visualizacion en localhost/_
## Detencion de servicios
~~~
docker compose stop
docker compose down
~~~
---

## Creación de la carpeta 
~~~
mkdir docker-moodle && cd docker-moodle 
~~~
---
## Clonado del repositorio a docker-compose
~~~
curl -sSL 
https://raw.githubusercontent.com/bitnami/containers/main/bitnami/moodle/docker
compose.yml > docker-compose.yml  
~~~

## Creacion de la red (network)
---

~~~
docker network create moodle-network 
~~~

## Creacion del volumen
---
### Creacion del volumen de mariadb
~~~
docker volume create --name mariadb_data 
docker run -d --name mariadb \ --env ALLOW_EMPTY_PASSWORD=yes \ --env MARIADB_USER=bn_moodle \ --env MARIADB_PASSWORD=bitnami \ --env MARIADB_DATABASE=bitnami_moodle \ --network moodle-network \ --volume mariadb_data:/bitnami/mariadb \ 
bitnami/mariadb:latest 
~~~

### Creacion del columen del moodle
~~~
docker volume create --name moodle_data 
docker run -d --name moodle \ -p 8080:8080 -p 8443:8443 \ --env ALLOW_EMPTY_PASSWORD=yes \ --env MOODLE_DATABASE_USER=bn_moodle \ --env MOODLE_DATABASE_PASSWORD=bitnami \ --env MOODLE_DATABASE_NAME=bitnami_moodle \ --network moodle-network \ --volume moodle_data:/bitnami/moodle \ --volume moodledata_data:/bitnami/moodledata \ 
bitnami/moodle:latest
~~~

## Levantar el servicio
---
~~~
docker-compose up -d
~~~


# Control de docker
~~~
docker ps
~~~
