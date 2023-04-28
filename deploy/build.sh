#!/bin/bash

source ./deploy/variables

sudo rm ${APP_NAME}_web.tar.gz
sudo rm ${APP_NAME}_app.tar.gz

sudo docker-compose build

sudo docker save ${APP_NAME}_web | gzip > ${APP_NAME}_web.tar.gz
sudo docker save ${APP_NAME}_app | gzip > ${APP_NAME}_app.tar.gz