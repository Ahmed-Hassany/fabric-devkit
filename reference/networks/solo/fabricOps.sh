#!/bin/bash

usage_message="Useage: $0 init | start-network | configure-network | start-explorer | status| clean | cleanall | clean-explorer"

ARGS_NUMBER="$#"
COMMAND="$1"

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
    docker-compose -f ./network-config.yaml up -d orderer.solo.network
    
    docker-compose -f ./network-config.yaml up -d ca.org1.solo.network
    docker-compose -f ./network-config.yaml up -d peer0.db.org1.solo.network
    docker-compose -f ./network-config.yaml up -d peer0.org1.solo.network
    docker-compose -f ./network-config.yaml up -d cli.org1.solo.network

    docker-compose -f ./network-config.yaml up -d ca.org2.solo.network
    docker-compose -f ./network-config.yaml up -d peer0.db.org2.solo.network
    docker-compose -f ./network-config.yaml up -d peer0.org2.solo.network
    docker-compose -f ./network-config.yaml up -d cli.org2.solo.network
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

function clearContainers(){
    docker rm -f orderer.solo.network
    
    docker rm -f ca.org1.solo.network
    docker rm -f peer0.db.org1.solo.network
    docker rm -f peer0.org1.solo.network
    docker rm -f cli.org1.solo.network

    docker rm -f ca.org2.solo.network
    docker rm -f peer0.db.org2.solo.network
    docker rm -f peer0.org2.solo.network
    docker rm -f cli.org2.solo.network   
}

clearContainers
createCryptoChannelArtefacts
renameSecretPrivKeys
startNetwork
createChannel
installChaincode
instantiateChaincode