#!/bin/bash

# package jar and move into /containers/apps
cd /testjar
mvn clean package
cp ./testjar/target/testApp1.jar ./containers/apps
cd ..

cd /containers/apps
docker-compose down --remove-orphans
docker-compose up --build -d --force-recreate









