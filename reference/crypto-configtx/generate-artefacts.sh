#!/bin/bash

CHANNEL_ONE_NAME=channelone
CHANNEL_ONE_PROFILE=ChannelOne
CHANNEL_TWO_NAME=channeltwo
CHANNEL_TWO_PROFILE=ChannelTwo
ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

if [ -d ./assets/channel-artifacts ]; then
    rm -rf ./assets/channel-artifacts
fi

if [ -d ./assets/crypto-config ]; then
    rm -rf ./assets/crypto-config
fi

cryptogen generate --config=./crypto-config.yaml --output="./assets/crypto-config"

if [ ! -d ./assets/channel-artifacts ]; then
    mkdir -p ./assets/channel-artifacts
fi

configtxgen -profile OrdererGenesis -outputBlock ./assets/channel-artifacts/genesis.block

configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./assets/channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME
configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./assets/channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME

# generate anchor peer for channelone transaction of org1 
configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./assets/channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org1MSP

# generate anchor peer for channelone channel transaction of org2
configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./assets/channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org2MSP

# generate anchor peer for channeltwo transaction of org2
configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./assets/channel-artifacts/Org2MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org2MSP