# Reference networks

You will find two predefined Fabric networks intended to help you:

* Orchestrate a one-organisation ([dev](../reference/networks/dev)) and two-organisations network ([kafka](../reference/networks/kafka)).
* Create and debug your application using the `dev` network.

This network uses docker technologies to help you create a locally running network. Please refer to [docker documentation](https://docs.docker.com/) to familarise with the technology. It is beyond the scope of this guide to cover those topics.

Please also refer to Fabric's [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/blockchain.html) to learn about the Fabric network. 

Please also ensure you have the [prequisite](./introduction.md#prequisite).

## Dev network

This network has is configured with one orderer, one certificate authority (ca) and one cli operating in solo mode. It is intended to support application development (chaincode and node client) and support experimentation with ca.

### Content

The `dev` network orchestrator is located [here](../reference/networks/dev)

| Item | Description |
| --- | --- |
| `cli-scripts` | This folder contains scripts to configure the Fabric network by creating channels, installing and instantiating chaincodes. |
| `fabricOps.sh` | Please refer to details [here](#fabricOps) |
| `configtx.yaml` | Channel specification |
| `crypto-config.yaml` | Crytographic artefact specification |
| `docker-compose.ca-client.yaml` | A docker orchestration specification for ca-client container |
| `docker-compose.fabric.yaml` | A docker orchestration specification for the principal Fabric containers  |
| `docker-compose.node-sdk.yaml` | A docker orchestration specification for the Fabric node sdk client container |
| `generate-artefacts.sh` | Script to execute configtxgen and cryptogen tool |
| `network-config.yaml` | Network configuration specification to help instantiate Fabric node sdk |
| `org1.yaml` | Client configuration specification |
| `services.json` | Client support configuration specification |

### <a name="fabricOps">fabricOps.sh</a>

The principal network orchestration script to help you spin-up, tear down and add supporting components to the network. It is a Bash script based command line application.

__Commands__

This is the top level command

`./fabricOps.sh network <subcommand> | ca-client <subcommand> | fabric-client <subcommand> | status | clean`
 
*network*

Use this command to create Fabric network related crytographic and channel arefects, and to spin-up a working dev Fabric network.
`./fabricOps.sh network artefacts | start`

*ca-client*

Use this command to add a CA Client instance to a running Fabric network. 

`./fabricOps.sh ca-client image | cli | start | clean`

Subcommands

* `image` - builds a new Docker image of Fabric CA Client tool
* `cli`- spin up a bash shell
* `start` - start an instance of Fabric CA Client instance
* `clean` - remove instances of Fabric CA Client

*fabric-client*

Use this command to add a fabric-client instance to a running Fabric network.

`./fabricOps.sh fabric-client image | start | clean`

Subcommands

* `image` - builds a new Docker image of Fabric client tool
* `start` - start an instance of the Fabric client tool
* `clean` - remove instance of the Fabric client tool

*status*

Use this command to get a list of the status instances running in the network.

`./fabricOps.sh status`

*clean*

Use this command to tear down *all* containers in the Fabric network

`./fabricOps.sh clean`

## Kafka

This is current being transition to a multi peers two organisation kafka network. It is still under development. Whilst this network is operational it is incomplete.