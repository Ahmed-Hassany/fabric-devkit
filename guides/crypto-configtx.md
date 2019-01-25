# Cryptogen and Configtxgen Lab 

`cryptogen` and `configtxgen` are Fabric tools used to create artefacts to enable the Fabric network to configure [Membership Service Provider (MSP)](https://hyperledger-fabric.readthedocs.io/en/release-1.4/msp.html) and [Channel configuration](https://hyperledger-fabric.readthedocs.io/en/release-1.4/configtx.html).

Please ensure you have the [prequisite](./introduction.md#prequisite).

## Content

| Item | Description |
| --- | --- |
| `configtx.yaml` | This is a configuration file use to specify channel configurations and genesis block. Please refer to [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/commands/configtxgen.html?highlight=configtx.yaml) |
| `crypto-config.yaml` | This is a configuration file used to specify cryptographic artefacts. Please refer to [official documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.4/msp.html#how-to-generate-msp-certificates-and-their-signing-keys) |

## How to use the lab

1. The lab is [here](./../reference/crypto-configtx).
2. Modify `configtx.yaml` and `crypto-config.yaml` to meet your requirement. By default these specs assumed configuration for one orderer, two orgs, one peer per org and two channels.
3. Execute `test.sh` and this will generate a folder `./assets`, which contains all the required cryptographic and channel artefacts.
