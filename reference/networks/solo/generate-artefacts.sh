#!/bin/bash

CHANNEL_NAME=mychannel
CHANNEL_PROFILE=MyChannel

if [ -d ./channel-artefacts ]; then
    rm -rf ./channel-artefacts
fi

if [ -d ./crypto-config ]; then
    rm -rf ./crypto-config
fi

cryptogen generate --config=./crypto-config.yml --output="./crypto-config"

if [ ! -d ./channel-artefacts ]; then
    mkdir -p ./channel-artefacts
fi

configtxgen -profile OrdererGenesis -outputBlock ./channel-artefacts/genesis.block

configtxgen -profile ${CHANNEL_PROFILE} -outputCreateChannelTx ./channel-artefacts/${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME

# generate anchor peer for channelone transaction of org1 
#configtxgen -profile ${CHANNEL_PROFILE} -outputAnchorPeersUpdate ./channel-artefacts/Org1MSPanchors_${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
