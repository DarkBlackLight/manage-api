#!/bin/bash

source ./deploy/variables

sudo docker-compose up -d

sudo docker exec $(sudo docker ps -q --filter ancestor="${APP_NAME}_app") rake dbm:setup_sdt_config
