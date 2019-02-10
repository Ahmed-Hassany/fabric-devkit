# Aladdin Fabric Developers' Kit

[Aladdin Healthcare Technologies Ltd](https://aladdinid.com/) sponsored the creation of a developers' toolkit (to be known here as the `DevKit`). The toolkit was developed by [Elemental Concept](http://elementalconcept.com/) which was used to build a Hyperledger Fabric (Fabric) based [Proof-of-Concept (PoC) medical audit application](https://www.youtube.com/watch?v=vJmhwymh-eU).

Following from the PoC, Aladdin has kindly open sourced and donated the `DevKit` and make it available to the wider blockchain developers' community to support Fabric applications development effort.

The maintainer(s) of this project is grateful to Aladdin for sponsoring the effort to create the kit and donating the code to this community.

# Design Goals

The design goals of kit are to help developers and platform engineers:

* learn through a series of smoke tests and reference networks, the system architecture of Hyperledger Fabric;
* to define, instantiate and configure a Fabric network to support development effort or learn to orchestrate a Kafka based Fabric network;
* to help debug chaincodes and client apps.

# How to use the DevKit

1. Learn to use [Docker](https://docs.docker.com/).

2. Set up as you would for [Go chaincode development](https://github.com/workingwithblockchain/writing-go-chaincodes#setupDevEnv)

3. Verify that you have a root directory referenced by `$GOPATH` environment variable containing these directories:
```
drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 bin
drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 pkg
drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 src
```

4. Navigate to `$GOPATH` and clone this repository via this command:
```
go get github.com/workingwithblockchain/fabric-devkit
```

5. Please refer to the following use cases for the `DevKit`:

| User story | Guide |
| --- | --- |
| As a developer, I would like to be able to spin up a small Fabric network locally, so I can debug my chaincode and app developed using Fabric SDK | [dev network](./guides/dev-network.md)|
| As a platform engineer, I would like to see a fairly realistic working Kafka based Fabric network, so I can learn to set-up one | [kafka network]() |
| As a platform engineer, I would like to be able to conduct experiment with Fabric's cryptogen and configtxgen toolkit and associated configuration files without the need for complex set-up | [crypto-configtx](./guides/crypto-configtx.md) |
| As a platform engineer, I would like to be able to inspect the internals of an operational Fabric Certificate Authority (CA) whilst performing enrollment and registration, so I know how to debug the CA. | [Fabric CA guides](./guides/fabric-ca.md) |
| As a developer, I would like to be able to inspect the internals of an operational Fabric Certificate Authority (CA) whilst performing enrollment and registration, so I can diagnose problems caused by my application whilst interacting with the CA | [Fabric CA guides](./guides/fabric-ca.md) |
| As a developer, I would like to have a pre-built simple RESTful nodeJS based component that is able to interact with the reference networks, so I learn to create apps using `fabric-node-client` sdk | [fabric-node-client](./guides/fabric-node-client.md)|

# Release Notes

| Version | Features | Status |
| --- | --- | --- |
| 0.1 | + Implementation named twoorgs.<br> + Network components based on Fabric 1.1.0 containers and docker compose.<br> + Bash based scripts to support kit orchestration - i.e. macOS and Ubuntu based | + Released.<br> + No further update. |
| 0.2 | + Support for Fabric 1.4.<br> + A laboratory for platform engineers to learn to create cryptographic materials using cryptogen and configtxgen.<br> + A fabric-ca-client cli extension to enable developer smoke test a running fabric-ca-server.<br> + A Fabric network configured to support development work and laboratory exercises.<br> + Two pre-configured networks: a one-org network, and a two-organisations multi-channel network.<br> + A simple `fabric-node-sdk` based RESTful container intended to enable interactions with the pre-configured networks. | + Under development |

Please also refer to this [user journey](https://www.pivotaltracker.com/n/projects/2181160) to follow the DevKit's development lifecycle.

# Contributions and Feedback

The maintainer(s) of this project welcomes feedback and contribution from anyone. 

To maintain some order in this project development lifecycle, the principal maintainer shall, currently, retain sole descretion in deciding any features to be incorporated or removed from this repository. 

It is worth emphasising that the long term goal is to have this project supported by multiple maintainers to ensure that there is no single-point-of-failure. A consensus mechanism that can enable this project involve multiple maintainers is currently being established.

# Maintainers

| Role | Name |
| --- | --- |
| Principal maintainer | Paul Sitoh (Elemental Concept) |

# Disclaimer

Unless otherwise specified, the artefacts in this repository are distributed under Apache 2 license.

All artefacts found here are provided on "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.