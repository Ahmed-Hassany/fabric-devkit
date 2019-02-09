# Dev Network

Please refer to Fabric's [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/blockchain.html) to learn about the Fabric network.

This network has been configured to instantiate at it's core an organisation comprising one orderer, one certificate authority (ca) and one cli container operating in solo mode. The network can be extended to include a ca-client cli container and/or to include a RESTFul fabric-node-client based container.

# Content

The dev network orchestrator is located [here](../networks/dev)

| Item | Description |
| --- | --- |
| `cli-scripts` | This folder contains scripts to configure the dev network by creating channels, installing and instantiating chaincodes |
| `fabricOps.sh` | Please refer to details [here](#fabricOps) |
| `configtx.yaml` | Channel specification please refer to [crypto-configtx guide for details](./crypto-configtx.md)  |
| `crypto-config.yaml` | Crytographic artefact specification [crypto-configtx guide for details](./crypto-configtx.md) |
| `docker-compose.ca-client.yaml` | An orchestration file for [ca-client-cli container](./fabric-ca.md) |
| `docker-compose.fabric.yaml` | An orchestration file for the dev network |
| `docker-compose.fabric-node-client.yaml` | An orchestration file for the [Fabric node client container](./fabric-node-client.md) |
| `generate-artefacts.sh` | Script to execute configtxgen and cryptogen tool |
| `network-config.yaml` | Network configuration file specifying fabric components involve in the network |
| `org1.yaml` | A configuration file for a client container connecting to the Fabric network |
| `services.json` | A configuration file intended to help NodeJS based client to read `network-config.yaml` and `org1.yaml` |

# <a name="fabricOps">fabricOps.sh</a>

The principal network orchestration script to help you spin-up, tear down and add supporting components to the network. It is a Bash script based command line application.

## Commands

This is the top level command

`./fabricOps.sh network <subcommand> | ca-client <subcommand> | fabric-node-client <subcommand> | status | clean`
 
### `network` command

Command to create Fabric network related crytographic and channel arefects, and to spin-up a working dev Fabric network.

```
./fabricOps.sh network artefacts | start
```

| Subcommand | Description |
| --- | --- |
| `artefacts` | Create cryptographic and channel artefacts |
| `start` | Instantiate the dev network |

## `ca-client` command 

Use this command to add a CA client instance to a running Fabric network. 

```
./fabricOps.sh ca-client image | cli | start | clean
```

| Subcommand | Description |
| --- | --- |
| `image` | builds a new Docker image of Fabric CA Client tool |
| `cli` | spin up a bash shell |
| `start` | start an instance of Fabric CA Client container |
| `clean` | remove instances of Fabric CA Client container |

## fabric-node-client

Use this command to add a fabric-client instance to a running Fabric network.

```
./fabricOps.sh fabric-node-client image | start | clean
```

| Subcommand | Description |
| --- | --- |
| `image` | Builds a new Docker image of Fabric client tool |
| `start` | start an instance of the Fabric client tool |
| `clean` | remove instance of the Fabric client tool |

## status

Use this command to get a list of the status instances running in the network.

```
./fabricOps.sh status
```

## clean

Use this command to tear down *all* containers in the Fabric network

```
./fabricOps.sh clean
```
