#!/bin/bash

docker rm -f test-node
docker-compose -f test-container/docker-compose.yaml build
docker-compose -f test-container/docker-compose.yaml up -d test-node