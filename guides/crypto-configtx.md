# Cryptogen and Configtxgen Lab 

The purpose of this lab is to help you experiment with Fabric's `cryptogen` and `configtxgen` tools. These are tools used to create artefacts to enable the Fabric network to configure [Membership Service Provider (MSP)](https://hyperledger-fabric.readthedocs.io/en/release-1.4/msp.html) and [Channel configuration](https://hyperledger-fabric.readthedocs.io/en/release-1.4/configtx.html).

Please ensure you have the [prequisite](./introduction.md#prequisite).


## Content

The lab is [here](../reference/crypto-configtx).

| Item | Description |
| --- | --- |
| `configtx.yaml` | This is a file to specify channel configurations and genesis block. Please refer to [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/commands/configtxgen.html?highlight=configtx.yaml) for use case. |
| `crypto-config.yaml` | This is a file to specify cryptographic artefacts. Please refer to [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/msp.html#how-to-generate-msp-certificates-and-their-signing-keys) for use case. |

## How to use the lab

1. Modify [configtx.yaml](../reference/crypto-configtx/configtx.yaml) and [crypto-config.yaml](../reference/crypto-configtx/crypto-config.yaml) to meet your requirement.
2. Navigate to the [lab](../reference/crypto-configtx).
3. Execute `test.sh` and this will generate a folder `./assets` where you will find all the required cryptographic and channel artefacts as specified in step 1.
