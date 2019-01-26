#!/bin/bash

usage_message="Useage: $0 build | start | cli | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function buildCAClientImage(){
    pushd ../../fabric-ca-client
        docker build -t workingwithblockchain/ca-client-toolkit .
    popd
}

function cli(){
    docker exec -it ca.client.org1.dev /bin/bash
}

function startClient(){
    docker-compose -f ./docker-compose.ca-client.yaml up -d ca.client.org1.dev
}

function clean(){
    docker rm -f ca.client.org1.dev
    docker rmi -f workingwithblockchain/ca-client-toolkit
    rm -rf ../../fabric-ca-client/msp
}

case $COMMAND in
    "build")
        buildCAClientImage
        ;;
    "start")
        startClient
        ;;
    "cli")
        cli
        ;;
    "clean")
        clean
        ;;
    *)
        echo usage_message
        ;;
esac