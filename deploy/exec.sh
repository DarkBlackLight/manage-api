#!/bin/bash

source ./deploy/variables

sudo docker exec -it $(sudo docker ps -q --filter ancestor="${APP_NAME}_app") bash