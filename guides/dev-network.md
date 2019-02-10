# Dev Network

Please refer to Fabric's [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/blockchain.html) to learn about the Fabric network.

This network has been configured to instantiate an organisation comprising one orderer, one certificate authority (ca) and one cli container operating in solo mode. The network can be extended to include a ca-client cli container and/or to include a RESTFul fabric-node-client based container.

# How to use the dev network

* [Debug chaincode](#debugChaincode)
* [Debug fabric-sdk app](#debugSDK)

## <a name="debugChaincode">Debug chaincode</a>

Step 1: Assuming that you have created a repository of a containing chaincodes in `$GOPATH/src/github.com/project/go-chaincodes` and you package your chaincodes under `$GOPATH/src/github.com/project/go-chaincodes/my-cc`.

Step 2: Modify the file [`.env`](#detEnv), value `CHAINCODE_PATH` to reference `$GOPATH/src/github.com/project/go-chaincodes`.

## <a name="debugSDK">Debug SDK app</a>

Please refer to [fabric-node-client](../extensions/fabric-node-client). This is a simple example to illustrate steps for creating a NodeJS based application via fabric-client SDK. This should apply to app written in any other language.

STEP 1: Assuming that the node source code is held in `$GOPATH/src/github.com/project/my-node-app` (this is only an example, you can place it anywhere).

STEP 2: Package your app into a Docker image (see example code).

STEP 3: Modify `fabricOps.sh` section name `Fabric Client` and the attribute `fabric-client-image` to the image of your choice and the functions `unitTestFabricClient()`, `smokeTestFabricClient()` accordingly.

STEP 4: Modify the file [`docker-compose.fabric-client.yaml`](#fabricClientCompose) and make sure the image name matches the name you mentioned in STEP 3.

# Content

The dev network orchestrator is located [here](../networks/dev)

| Item | Description |
| --- | --- |
| `.env` | Shared orchestrator environmental variables |
| `cli-scripts` | This folder contains scripts to configure the dev network by creating channels, installing and instantiating chaincodes |
| `configtx.yaml` | Channel specification please refer to [crypto-configtx guide for details](./crypto-configtx.md)  |
| `crypto-config.yaml` | Crytographic artefact specification [crypto-configtx guide for details](./crypto-configtx.md) |
| `docker-compose.ca-client.yaml` | An orchestration file for [ca-client-cli container](./fabric-ca.md) |
| `docker-compose.fabric.yaml` | An orchestration file for the dev network |
| `docker-compose.fabric-client.yaml` | An orchestration [file](#fabricClientCompose) for the Fabric client container |
| `fabricOps.sh` | Please refer to details [here](#fabricOps) |
| `generate-artefacts.sh` | Script to execute configtxgen and cryptogen tool |
| `network-config.yaml` | Network configuration file specifying fabric components involve in the network |
| `org1.yaml` | A configuration file for a client container connecting to the Fabric network |
| `services.json` | A configuration file intended to help NodeJS based client to read `network-config.yaml` and `org1.yaml` |

## <a name="dotEvn">.env</a>

Modify the file `.env` to specify its content accordingly:

```
COMPOSE_PROJECT_NAME=dev
NETWORKS=fabric-network
CA_IMAGE_TAG=1.4.0
PEER_IMAGE_TAG=1.4.0
ORDERER_IMAGE_TAG=1.4.0
FABRIC_TOOL_IMAGE_TAG=latest
CHAINCODE_PATH=../../chaincodes/
```

**NOTE:** Do not modify `COMPOSE_PROJECT_NAME` and `NETWORKS`

## <a name="fabricClientCompose">docker-compose.fabric-client.yaml</a>

In the file:

```
  fabric-client.org1.dev:
    image: workingwithblockchain/fabric-node-client
    volumes:
      - ./network-config.yaml:/opt/network-config.yaml
      - ./org1.yaml:/opt/org1.yaml
      - ./services.json:/opt/services.json
      - ./crypto-config:/opt/crypto-config
      - ./channel-artefacts:/opt/channel-artefacts
      - ../../extensions/fabric-node-client/test:/opt/test
      - ../../extensions/fabric-node-client/wallet:/tmp
```

If you wish to switch to a different fabric app, simply switch the attribute `image` to your choice. 

## <a name="fabricOps">fabricOps.sh</a>

The principal network orchestration script to help you spin-up, tear down and add supporting components to the network. It is a Bash script based command line application.

### Commands

This is the top level command

`./fabricOps.sh network <subcommand> | ca-client <subcommand> | fabric-node-client <subcommand> | status | clean`
 
#### `network` command

Command to create Fabric network related crytographic and channel arefects, and to spin-up a working dev Fabric network.

```
./fabricOps.sh network artefacts | start
```

| Subcommand | Description |
| --- | --- |
| `artefacts` | Create cryptographic and channel artefacts |
| `start` | Instantiate the dev network |

#### `ca-client` command 

Command to add a CA client container to a running Fabric network. 

```
./fabricOps.sh ca-client image | cli | start | clean
```

| Subcommand | Description |
| --- | --- |
| `image` | builds a new Docker image of Fabric CA Client tool |
| `cli` | spin up a bash shell |
| `start` | start an instance of Fabric CA Client container |
| `clean` | remove instances of Fabric CA Client container |

#### `fabric-node-client` command

Command to add a fabric-client instance to a running Fabric network.

```
./fabricOps.sh fabric-node-client image | start | clean
```

| Subcommand | Description |
| --- | --- |
| `image` | Builds a new Docker image of Fabric client tool |
| `start` | start an instance of the Fabric client tool |
| `clean` | remove instance of the Fabric client tool |

#### `status` command

Command to get a list of the status instances running in the network.

```
./fabricOps.sh status
```

#### `clean` command

Command to tear down *all* containers in the Fabric network

```
./fabricOps.sh clean
```
