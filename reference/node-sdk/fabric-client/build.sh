#!/bin/bash

usage_message="Useage: $0 image | start-network | unit | smoke | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function startDevNetwork(){
    pushd ../../networks/dev/
        ./fabricOps.sh start
    popd
}

function buildTestImage(){
    docker build --target test -t workingwithblockchain/fabric-client-node .
}

function runUnitTest(){
    pushd ../../networks/dev/
        docker-compose -f docker-compose.node-sdk.yaml run --rm fabric-client-node.dev /bin/bash -c 'npm run unit:test'
    popd
}

function runSmokeTest(){
    pushd ../../networks/dev/
        docker-compose -f docker-compose.node-sdk.yaml run --rm fabric-client-node.dev /bin/bash -c 'npm run smoke:test'
    popd
}

function clean(){
    pushd ../../networks/dev/
        ./fabricOps.sh clean
    popd
    rm -rf ./wallet
    docker rmi -f workingwithblockchain/fabric-client-node
    docker rmi -f $(docker images -f "dangling=true" -q)
}

case $COMMAND in
    "image")
        buildTestImage
        ;;
    "start-network")
        startDevNetwork
        ;;
    "unit")
        runUnitTest
        ;;
    "smoke")
        runSmokeTest
        ;;
    "clean")
        clean
        ;;
    *)
        echo $usage_message
        ;;
esac