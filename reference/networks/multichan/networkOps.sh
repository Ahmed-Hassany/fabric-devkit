#!/bin/bash

docker-compose up -d orderer.example.com
docker-compose up -d couchdb0
docker-compose up -d couchdb1
docker-compose up -d peer0.org1.example.com
docker-compose up -d peer0.org2.example.com
docker-compose up -d cli