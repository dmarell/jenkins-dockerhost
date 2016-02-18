#!/bin/sh
set -e
sudo docker-compose build
sudo service jenkins-dockerhost restart
