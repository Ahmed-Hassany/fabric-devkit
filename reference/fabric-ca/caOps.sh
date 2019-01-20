#!/bin/bash

usage_message="Useage: $0 start | cli | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function createCAClientToolkit(){
    docker build -t workingwithblockchain/fabric-ca-client-toolkit .
}

function clearCAClientToolkitAssets(){
    docker rmi -f workingwithblockchain/fabric-ca-client-toolkit
    rm -rf ./msp
}

function startFabricNetwork(){
    pushd ../networks/dev
        ./fabricOps.sh start
    popd
}

function cleanFabricNetwork(){
    pushd ../networks/dev
        ./fabricOps.sh clean
    popd
}

case $COMMAND in
    "start")
        startFabricNetwork
        clearCAClientToolkitAssets
        createCAClientToolkit
        ;;
    "cli")
        docker-compose run ca-cli.dev
        ;;
    "clean")
        cleanFabricNetwork
        clearCAClientToolkitAssets
        ;;
esac