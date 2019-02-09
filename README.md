# Aladdin Fabric Developers' Kit

[Aladdin Healthcare Technologies Ltd](https://aladdinid.com/) sponsored the creation of the developers' kit, which was codename `Maejor`. The kit was developed by [Elemental Concept](http://elementalconcept.com/) which was used to build a Hyperledger Fabric (Fabric) based [Proof-of-Concept (PoC) medical audit application](https://www.youtube.com/watch?v=vJmhwymh-eU).

Following from the PoC, Aladdin has kindly open sourced and donated the developers' kit and make it available to the wider blockchain developers' community to support application development effort and add more features.

The maintainer(s) of this project is grateful to Aladdin for sponsoring the effort to create the kit and donating the code to this community.

## Design goals

The design goals of the kit are to help developers:

* learn through a series of smoke tests and reference networks, the system architecture of Hyperledger Fabric;
* define, instantiate and configure a Fabric network to support development effort;
* verify that apps interacting with the Fabric network meets expectations.

## Content

The Fabric developers' kit compromise of the following items:

| Item | Description |
| --- | --- |
| [`chaincodes`](./chaincodes) | Example Go chaincodes |
| [`networks`](./networks) | Preconfigured core networks intended to support application development and help platform engineers appreciate the system architecture of a operational Fabric network |
| [`extensions`](./extensions) | Addition to core elements of the core Fabric networks |
| [`guides`](./guides/introduction.md) | How to use the developers' kit |

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

* A laboratory for platform engineers to learn to create cryptographic materials using cryptogen and configtxgen.
* A fabric-ca-client cli extension to enable developer smoke test a running fabric-ca-server.
* A Fabric network configured to support development work and laboratory exercises.
* Two pre-configured networks:
  * A one-org network to provide developer with quick development feedback without the need for a fully configure network;
  * A two-organisations multi-channel network configured to help application developers verify apps deployed in a fairly realistic network and to a working reference for platform engineers to gain inspiration to scale up to a production network.
* A simple `fabric-node-sdk` based RESTful container intended to enable interactions with the pre-configured networks 

Status:

* Under development

## Contributions and feedback

The maintainer(s) of this project welcomes feedback and contribution from anyone. 

To maintain some order in this project development lifecycle, the principal maintainer shall, currently, retain sole descretion in deciding any features to be incorporated or removed from this repository. 

It is worth emphasising that the long term goal is to have this project supported by multiple maintainers to ensure that there is no single-point-of-failure. A consensus mechanism that can enable this project involve multiple maintainers is currently being established.

## Maintainers

| Role | Name |
| --- | --- |
| Principal maintainer | Paul Sitoh (Elemental Concept) |

## Disclaimer

Unless otherwise specified, the artefacts in this repository are distributed under Apache 2 license.

All artefacts found here are provided on "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.