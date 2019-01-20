#!/bin/bash

usage_message="Useage: $0 init | unit | smoke | production | clean"

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
    docker-compose run --rm fabric-client-node.dev /bin/bash -c 'npm run unit:test'
}

function runSmokeTest(){
    docker-compose run --rm fabric-client-node.dev /bin/bash -c 'npm run smoke:test'
}

function clean(){
    pushd ../../networks/dev/
        ./fabricOps.sh clean
    popd
    rm -rf ./tmp
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
    "smoke")
        runSmokeTest
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