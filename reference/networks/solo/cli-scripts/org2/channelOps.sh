#!/bin/bash

. ./share/common.sh

peer channel fetch newest -o $ORDERER -c $CHANNEL_NAME --tls --cafile $ORDERER_CA ./$CHANNEL_NAME.block
peer channel join -o $ORDERER -b ./$CHANNEL_NAME.block --tls --cafile $ORDERER_CA