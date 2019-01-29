# Reference networks

You will find two predefined Fabric networks intended to help you:

* Orchestrate a one-organisation ([dev](../reference/networks/dev) ) and two-organisations network ([kafka](../reference/networks/kafka)).
* Create and debug your application.

## Dev network

This network has is configured with one orderer, one certificate authority (ca) and one cli operating in solo mode. It is intended to support application development (chaincode and node client) and support experimentation with ca.

### Content

The dev network is located [here](../reference/networks/dev)

| Item | Description |
| --- | --- |
| `cli-scripts` | This folder contains scripts to configure the Fabric network by creating channels, installing and instantiating chaincodes. |
| `fabricOps.sh` | The principal network orchestration script to help you spin-up, tear down and add supporting components to the network. |
| `configtx.yaml` | Channel specification |
| `crypto-config.yaml` | Crytographic artefact specification |
| `docker-compose.ca-client.yaml` | A docker orchestration specification for ca-client container |
| `docker-compose.fabric.yaml` | A docker orchestration specification for the principal Fabric containers  |
| `docker-compose.node-sdk.yaml` | A docker orchestration specification for the Fabric node sdk client container |
| `generate-artefacts.sh` | Script to execute configtxgen and cryptogen tool |
| `network-config.yaml` | Network configuration specification to help instantiate Fabric node sdk |
| `org1.yaml` | Client configuration specification |
| `services.json` | Client support configuration specification |

### fabricOps.sh

As a developer you need to concern yourself with this particular script.

## Kafka

This is current being transition to a multi peers two organisation kafka network. It is still under development. Whilst this network is operational it is incomplete.