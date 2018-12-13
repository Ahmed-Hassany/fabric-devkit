#!/bin/bash

command=$1
option=$2
caversion=$3

message="Usage: $0 start <ca-version> | reset | cli"

function pullDockerImages(){

    if [ -z $caversion ]; then
        docker pull hyperledger/fabric-ca
    else
        docker pull hyperledger/fabric-ca:$caversion
        docker pull hyperledger/fabric-ca:$caversion  hyperledger/fabric-ca
    fi

}

function cleanGeneratedItems(){

    if [ -d ./fabric-ca-client-home ]; then
        rm -rf ./fabric-ca-client-home
    fi

    if [ -d ./fabric-ca-server ]; then
        rm -rf ./fabric-ca-server
    fi

}

case $command in
    start)
        pullDockerImages
        docker-compose up -d
        ;;
    reset)
        docker rm -f fabric-ca-server client-cli
        docker rmi -f hyperledger/fabric-ca local/fabric-ca-testkit
        cleanGeneratedItems
        ;;
    cli)
        docker exec -it client-cli /bin/bash
        ;;
    *)
        echo $message
        ;;
esac
