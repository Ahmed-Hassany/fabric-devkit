#!/bin/bash

usage_message="Useage: $0 start | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function clean(){
    docker rm -f rest.org1.dev
    docker rmi -f workingwithblockchain/fabric-client-rest
}

function start(){
    pushd ../../node-sdk/fabric-client
        ./build.sh image
    popd
    docker-compose -f ./docker-compose.node-sdk.yaml up -d rest.org1.dev
}

case $COMMAND in
    "start")
        clean
        start
        ;;
    "clean")
        clean
        ;;
    *)
        echo usage_message
        ;;
esac