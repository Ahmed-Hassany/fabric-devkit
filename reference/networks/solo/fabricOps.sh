#!/bin/bash

usage_message="Useage: $0 init | status | re-start | clean "

ARGS_NUMBER="$#"
COMMAND="$1"

chaincode_containers=$(docker ps -a | grep dev-peer* | awk '/dev-peer*/ {print $1}')
chaincode_images=$(docker images | grep dev-peer* | awk '/dev-peer*/ {print $3}')

function createCryptoChannelArtefacts(){
    rm -rf ./channel-artefacts
    rm -rf ./crypto-config
    docker run --rm -e "GOPATH=/opt/gopath" -e "FABRIC_CFG_PATH=/opt/gopath/src/github.com/hyperledger/fabric" -w="/opt/gopath/src/github.com/hyperledger/fabric" --volume=${PWD}:/opt/gopath/src/github.com/hyperledger/fabric hyperledger/fabric-tools /bin/bash -c '${PWD}/generate-artefacts.sh'
}

function renameSecretPrivKeys(){
    pushd ./crypto-config/peerOrganizations/org1.solo.network/ca
        PK=$(ls *_sk)
        mv $PK secret.key
    popd

    pushd ./crypto-config/peerOrganizations/org2.solo.network/ca
        PK=$(ls *_sk)
        mv $PK secret.key
    popd

    pushd ./crypto-config/peerOrganizations/org1.solo.network/users/Admin@org1.solo.network/msp/keystore
        PK=$(ls *_sk)
        mv $PK secret.key
    popd

    pushd ./crypto-config/peerOrganizations/org2.solo.network/users/Admin@org2.solo.network/msp/keystore
        PK=$(ls *_sk)
        mv $PK secret.key
    popd
}

function startNetwork(){
    docker-compose -f ./docker-compose.yaml up -d orderer.solo.network
    
    docker-compose -f ./docker-compose.yaml up -d ca.org1.solo.network
    docker-compose -f ./docker-compose.yaml up -d peer0.db.org1.solo.network
    docker-compose -f ./docker-compose.yaml up -d peer0.org1.solo.network
    docker-compose -f ./docker-compose.yaml up -d cli.org1.solo.network

    docker-compose -f ./docker-compose.yaml up -d ca.org2.solo.network
    docker-compose -f ./docker-compose.yaml up -d peer0.db.org2.solo.network
    docker-compose -f ./docker-compose.yaml up -d peer0.org2.solo.network
    docker-compose -f ./docker-compose.yaml up -d cli.org2.solo.network
}

function createChannel(){
    docker exec cli.org1.solo.network /bin/bash -c '${PWD}/scripts/channelOps.sh'
    docker exec cli.org2.solo.network /bin/bash -c '${PWD}/scripts/channelOps.sh'
}

function installChaincode(){
    docker exec cli.org1.solo.network /bin/bash -c '${PWD}/scripts/installCC.sh'
    docker exec cli.org2.solo.network /bin/bash -c '${PWD}/scripts/installCC.sh'
}

function instantiateChaincode(){
    docker exec cli.org1.solo.network /bin/bash -c '${PWD}/scripts/instantiateCC.sh'
}

function clearFabricAssets(){
    rm -rf ./channel-artefacts
    rm -rf ./crypto-config
}

function status(){

    echo "------------------------------------"
    echo "--       Running containers       --"
    echo "------------------------------------"
    docker ps --filter status=running
    echo

    echo "------------------------------------"
    echo "--       Stopped containers       --"
    echo "------------------------------------"
    docker ps --filter status=exited
}

function clearContainers(){

    echo "Removing chaincode containers"
    echo
    if [ ! -z $chaincode_containers ]; then
        docker rm -f $chaincode_containers
    fi

    echo "Removing chaincode images"
    echo
    if [ ! -z $chaincode_images ]; then
        docker rmi -f $chaincode_images
    fi
    echo

    echo "Removing orderer containers"
    docker rm -f orderer.solo.network
    echo

    echo "Removing org1 containers"
    docker rm -f ca.org1.solo.network
    docker rm -f peer0.db.org1.solo.network
    docker rm -f peer0.org1.solo.network
    docker rm -f cli.org1.solo.network
    echo
    
    echo "Removing org2 containers"
    docker rm -f ca.org2.solo.network
    docker rm -f peer0.db.org2.solo.network
    docker rm -f peer0.org2.solo.network
    docker rm -f cli.org2.solo.network   
}

case $COMMAND in
    "init")
        clearFabricAssets
        clearContainers
        createCryptoChannelArtefacts
        renameSecretPrivKeys
        startNetwork
        createChannel
        installChaincode
        instantiateChaincode
        ;;
    "re-start")
        clearContainers
        startNetwork
        createChannel
        installChaincode
        instantiateChaincode
        ;;
    "status")
        status
        ;;
    "clean")
        clearFabricAssets
        clearContainers
        ;;				
    *)
        echo $usage_message
        exit 1
esac