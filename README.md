# Aladdin Fabric Development Kit

[Aladdin Healthcare Technologies Ltd](https://aladdinid.com/) sponsored the creation of the Fabric development kit, which was codename `Maejor`. The kit was developed by [Elemental Concept](http://elementalconcept.com/) who then use it to build a Fabric based [Proof-of-Concept (PoC) medical audit trail](https://www.youtube.com/watch?v=vJmhwymh-eU). 

Following from the PoC, Aladdin has kindly open source the developer kit and make it available to the wider Blockchain developers' community to add more features.

The maintainer(s) of this project is grateful to Aladdin for sponsoring the effort to create the kit and donating the code to this community.

## Design goals

The design goals of the kit are to help developers:

* learn, through a series of smoke tests, the system architecture of Hyperledger Fabric (Fabric);
* define, instantiate and configure a Fabric network to support development effort;
* verify that apps developed to interact with the Fabric network meets expectation.

The development kit has three components:

* Example Go chaincodes;
* Reference networks and laboratories for experimentation;
* Command line interface (CLI) known as `maejor`.

## Release notes

### v0.1

Features:

* Implementation named twoorgs.
* Network components based on Fabric 1.1.0 containers and docker compose
* Bash based scripts to support kit orchestration - i.e. macOS and Ubuntu based

Status:

* Released
* No further update

### v0.2

Features:

* Laboratory for cryptogen and configtxgen experimentation.
* Laboratory for fabric-ca experimentation.
* A Fabric network configured to support development work and laboratory exercises.
* Two reference networks:
  * A one-org network configured with deep instrumentation to support development;
  * A two-organisations network with multi-channel configuration and currently configured for solo ordering.
* A `fabric-node-sdk` laboratory comprising of:
  * A section for developing using the `fabric-client` SDK.

## Content

| Item | Description |
| --- | --- |
| `chaincodes` | Example Go chaincodes |
| `guides` | How-to documentation |
| `maejor` | Source codes for `maejor` application |
| `reference` | A collection of smoke testing implementation of a fabric network setup |

### Chaincodes

| Item | Description |
| --- | --- |
| `minimalcc` | This is a simple chaincode illustrating the transfer to some numeric value between two parties. |
| `one` | This is a chaincode intended to be used in conjuction with `solo network` reference implementation. |
| `two` | This is a chaincode intended to be used in conjunction with `solo network` reference implementation. |

### Guides

| Item | Description |
| --- | --- |
| `two-orgs.md` | slated for removal |

### Maejor cli application

Please refer to [README](./maejor/README.md) for implementation information.

### Reference

This section contains a series of laboratories for small experimentation and reference networks.

| Item | Description |
| --- | --- |
| `crypto-configtx` | Smoke test to help developers appreciate the mechanics behind `cryptogen` and `configtxgen` |
| `fabric-ca` | Smoke test to help developers appreciate the operations of `fabric-ca` |
| `networks` | This contains examples of fabric networks |
| `twoorgs` | This is slated for removal |

## Contributions and feedback

The maintainer(s) of this project welcomes feedback and contribution from anyone. 

However, to manage the development lifecycle, Paul Sitoh of Elemental Concept shall be the principal maintainer, and retain sole descretion in deciding any features to be incorporated or removed from this repository. 

## Disclaimer

Unless otherwise specified, the artefacts in this repository are distributed under Apache 2 license.

All artefacts found here are provided on "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.