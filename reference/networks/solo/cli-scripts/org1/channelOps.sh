#!/bin/bash

. ./share/common.sh

peer channel create -o $ORDERER -c $CHANNEL_NAME -f ./channel-artefacts/$CHANNEL_NAME.tx --tls --cafile $ORDERER_CA
peer channel join -o $ORDERER -b ./$CHANNEL_NAME.block --tls --cafile $ORDERER_CA

