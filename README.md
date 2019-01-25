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

Status:

* Under development

## Content

| Item | Description |
| --- | --- |
| [`chaincodes`](./chaincodes) | Example Go chaincodes |
| [`guides`](./guides) | How-to documentation |
| [`maejor`](./maejor) | Source codes for `maejor` application |
| [`reference`](./reference) | A collection of smoke testing implementation of a fabric network setup |

## Contributions and feedback

The maintainer(s) of this project welcomes feedback and contribution from anyone. 

To maintain some order in this project development lifecycle, the principal maintainer shall, currently, retain sole descretion in deciding any features to be incorporated or removed from this repository. 

It is worth emphasising that the long term goal is to have this project supported by multiple maintainers to ensure that there is no single-point-of-failure. A consensus mechanism that can enable this project involve multiple maintainers is currently being established.

## Maintainers

Principal maintainer: Paul Sitoh (Elemental Concept).

## Disclaimer

Unless otherwise specified, the artefacts in this repository are distributed under Apache 2 license.

All artefacts found here are provided on "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.