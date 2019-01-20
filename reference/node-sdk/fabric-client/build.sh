#!/bin/bash

usage_message="Useage: $0 init | unit | production | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function startDevNetwork(){
    pushd ../../networks/dev/
        ./fabricOps.sh start
    popd
}

function productionBuildImage(){
    docker build -t paulwizviz/fabric-client-api .
    docker run paulwizviz/fabric-client-api
}

function testBuildImage(){
    docker build --target test -t workingwithblockchain/fabric-client-node .
}

function runUnitTest(){
    docker-compose run fabric-client-node.dev /bin/bash -c 'npm run unit:test'
}

function clean(){
    pushd ../../networks/dev/
        ./fabricOps.sh clean
    popd
    docker rmi -f workingwithblockchain/fabric-client-node
    docker rmi -f $(docker images -f "dangling=true" -q)
}

case $COMMAND in
    "init")
        startDevNetwork
        testBuildImage
        ;;
    "unit")
        runUnitTest
        ;;
    "production")
        productionBuild
        ;;
    "clean")
        clean
        ;;
    *)
        echo $usage_message
        ;;
esac