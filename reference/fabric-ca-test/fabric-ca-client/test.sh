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

case $command in
    start)
        pullDockerImages
        docker-compose up -d
        ;;
    reset)
        docker rm -f fabric-ca-server client-cli
        docker rmi -f hyperledger/fabric-ca local/fabric-ca-testkit
        ;;
    cli)
        docker exec -it client-cli /bin/bash
        ;;
    *)
        echo $message
        ;;
esac
