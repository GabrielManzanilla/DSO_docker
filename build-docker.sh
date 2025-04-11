#!/bin/bash

# Crear carpeta del proyecto y entrar en ella
mkdir -p docker-moodle && cd docker-moodle

# Descargar el archivo docker-compose.yml desde el repositorio oficial
curl -sSL https://raw.githubusercontent.com/bitnami/containers/main/bitnami/moodle/docker-compose.yml -o docker-compose.yml

# Crear red de Docker
docker network create moodle-network

# Crear volumen para MariaDB
docker volume create --name mariadb_data

# Ejecutar contenedor de MariaDB
docker run -d --name mariadb \
  --env ALLOW_EMPTY_PASSWORD=yes \
  --env MARIADB_USER=bn_moodle \
  --env MARIADB_PASSWORD=bitnami \
  --env MARIADB_DATABASE=bitnami_moodle \
  --network moodle-network \
  --volume mariadb_data:/bitnami/mariadb \
  bitnami/mariadb:latest

# Crear volumen para Moodle (base y moodledata)
docker volume create --name moodle_data
docker volume create --name moodledata_data

# Ejecutar contenedor de Moodle
docker run -d --name moodle \
  -p 8080:8080 -p 8443:8443 \
  --env ALLOW_EMPTY_PASSWORD=yes \
  --env MOODLE_DATABASE_USER=bn_moodle \
  --env MOODLE_DATABASE_PASSWORD=bitnami \
  --env MOODLE_DATABASE_NAME=bitnami_moodle \
  --network moodle-network \
  --volume moodle_data:/bitnami/moodle \
  --volume moodledata_data:/bitnami/moodledata \
  bitnami/moodle:latest

# Levantar el servicio con Docker Compose
docker-compose up -d

# Mostrar contenedores activos
docker ps
