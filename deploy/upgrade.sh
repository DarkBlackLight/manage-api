#!/bin/bash

git pull

bash ./deploy/build.sh
bash ./deploy/stop.sh
bash ./deploy/start.sh

sudo docker image prune -f