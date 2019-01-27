#!/bin/bash

usage_message="Useage: $0 start | clean"

ARGS_NUMBER="$#"
COMMAND="$1"

function createCryptoChannelArtefacts(){
    docker run --rm -e "GOPATH=/opt/gopath" -e "FABRIC_CFG_PATH=/opt/gopath/src/github.com/hyperledger/fabric" -w="/opt/gopath/src/github.com/hyperledger/fabric" --volume=${PWD}:/opt/gopath/src/github.com/hyperledger/fabric hyperledger/fabric-tools /bin/bash -c '${PWD}/generate-artefacts.sh'

    pushd ./crypto-config/peerOrganizations/org1.dev/ca
        PK=$(ls *_sk)
        mv $PK secret.key
    popd

    pushd ./crypto-config/peerOrganizations/org1.dev/users/Admin@org1.dev/msp/keystore
        PK=$(ls *_sk)
        mv $PK secret.key
    popd

}

function clearContainers(){
    docker rm -f $(docker ps --filter "network=dev_fabric-network" -aq)
}

function clearChaincodeImages(){
    cc_images=$( docker images -a | awk '/dev-*/ {print $3}' )
    docker rmi -f $cc_images
}

function clearCryptoChannelArtefacts(){
    rm -rf ./channel-artefacts
    rm -rf ./crypto-config
}

function clearFabricCAArtefacts(){
    rm -rf ./fabric-ca-home
}

function startNetwork(){
    docker-compose -f ./docker-compose.fabric.yaml up -d orderer.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d ca.org1.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d peer0.org1.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d cli.org1.dev

    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/channelOps.sh'
    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/installCC.sh'
    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/instantiateCC.sh'
}

case $COMMAND in
    "start")
        clearContainers
        clearChaincodeImages
        createCryptoChannelArtefacts
        clearFabricCAArtefacts
        startNetwork
        ;;
    "clean")
        clearContainers
        clearChaincodeImages
        clearCryptoChannelArtefacts
        clearFabricCAArtefacts
        ;;
    *)
        echo $usage_message
        ;;
esac