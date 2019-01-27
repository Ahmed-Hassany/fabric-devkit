#!/bin/bash

usage_message="Useage: $0 network <subcommand> | ca-client <subcommand> | status | clean"

ARGS_NUMBER="$#"
COMMAND="$1"
SUBCOMMAND="$2"

# Network
network_subcommand_message="Useage: $0 network artefacts | start"

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

function startContainers(){
    docker-compose -f ./docker-compose.fabric.yaml up -d orderer.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d ca.org1.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d peer0.org1.dev
    docker-compose -f ./docker-compose.fabric.yaml up -d cli.org1.dev
}

function initialiseNetwork(){
    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/channelOps.sh'
    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/installCC.sh'
    docker exec cli.org1.dev /bin/bash -c '${PWD}/scripts/instantiateCC.sh'
}

function startNetwork(){
    clearContainers
    clearCryptoChannelArtefacts
    createCryptoChannelArtefacts
    startContainers
    initialiseNetwork
}

function network(){
    subcommand="$1"
    case $subcommand in
        "artefacts")
            clearCryptoChannelArtefacts
            createCryptoChannelArtefacts
            ;;
        "start")
            startNetwork
            ;;
        *)
            echo $network_subcommand_message
            ;;
    esac
}

# CA Client
ca_client_image="workingwithblockchain/ca-client-toolkit"
ca_client_container="ca.client.org1.dev"
ca_client_subcommand_message="Useage: $0 ca-client image | start"

function buildCAClientImage(){
    pushd ../../fabric-ca-client
        docker build -t $ca_client_image .
    popd
}

function caStatus(){
    result=$(docker ps -a --format "{{.ID}}" --filter name=$ca_client_container --filter status=running)
    if [ -z $result ]; then
        return 1
    else
        return 0
    fi
}

function caCAClientCLI(){
    docker exec -it $ca_client_container /bin/bash
}

function caCAClientStart(){
    docker-compose -f ./docker-compose.ca-client.yaml up -d $ca_client_container
}

function clearCAArtefacts(){
    rm -rf ./fabric-ca-home
}

function caClient(){
    subcommand="$1"
    case $subcommand in
        "image")
            buildCAClientImage
            ;;
        "start")
            buildCAClientImage
            caCAClientStart
            ;;
        *)
            echo $ca_client_subcommand_message
            ;;
    esac
}

# Fabric Ops
function fabricStatus(){
    docker ps -a
}

# Fabric Clean
function fabricClean(){
    clearContainers
    clearChaincodeImages
    clearCryptoChannelArtefacts
    clearCAArtefacts
}

case $COMMAND in
    "network")
        network $SUBCOMMAND
        ;;
    "ca-client")
        caClient $SUBCOMMAND
        ;;
    "status")
        fabricStatus
        ;;
    "clean")
        fabricClean
        ;;
    *)
        echo $usage_message
        ;;
esac