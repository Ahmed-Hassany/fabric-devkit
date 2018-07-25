#!/bin/bash

. ./scripts/common.sh

function usage(){ 
    echo "Usage: $0 <arguments>"
    echo "Usage: $0 <flags>"
    echo "Mandatory:"
    echo "   -c <cc id>         A unique string identifier"
    echo "   -v <cc version>    A numeric number"
    echo "Optional:"
    echo "   -a <cc argment>   <cc argument> must be in the form [\"method\", \"method-arg-1\", \"method-arg-2\"]"
    echo "   -l <language>     Option to deloy in language other Go, currenly only node"
}

if [ "$#" -eq "0" ]; then  
    usage
    exit
fi

while getopts "a:c:l:v:" opt; do
  case $opt in
    a)
      CHAINCODE_CONSTRUCTOR=$OPTARG
      ;;
    c)
      CHAINCODEID=$OPTARG
      ;;
    l)
      CHAINCODE_LANG=$OPTARG
      ;;
    v)
      CHAINCODE_VERSION=$OPTARG
      ;;
    \?)
      usage
      exit 1
      ;;
    :)
      usage
      exit 1
      ;;
  esac
done

if [ -z $CHAINCODE_CONSTRUCTOR ]; then
  CHAINCODE_CONSTRUCTOR="[]"
fi

if [ -z $CHAINCODE_LANG ]; then
  CHAINCODE_LANG="golang"
fi

if [[ ! -z $CHAINCODE_VERSION && ! -z $CHAINCODEID ]]; then

    echo "UPGRADING chaincode $CHAINCODEID to version $CHAINCODE_VERSION"
    echo "in $CHANNELNAME"
    echo "with constructor $CHAINCODE_CONSTRUCTOR"
    constructor="{\"Args\":$CHAINCODE_CONSTRUCTOR}"

    peer chaincode upgrade -o $ORDERER -C $CHANNELNAME -n $CHAINCODEID -l $CHAINCODE_LANG -v $CHAINCODE_VERSION -c $constructor --tls --cafile $ORDERER_CA
else
  usage
fi
