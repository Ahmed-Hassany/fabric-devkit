#!/bin/bash

docker-compose -f ./docker-compose.yml run --rm assets.generator /bin/bash -c '${PWD}/generate-artifacts.sh'