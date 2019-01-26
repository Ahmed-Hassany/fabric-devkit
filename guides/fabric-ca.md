# Fabric Certificate Authority Lab

Please refer to [official documentation](https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/) for detailed explanation of the operations of Fabric Certificate Authority.

In this Lab, which you can find it [here](../reference/fabric-ca-client), you are provided with the necessary specification to create a Fabric CA client. 

 the Fabric service instance found in a running [dev reference network](../reference/networks/dev).

Please ensure you have the [prequisite](./introduction.md#prequisite).

## Content

| Item | Description |
| --- | --- |
| `scripts` | Contains a series of bash scripts embedded in the Fabric client toolkit to: register a new identity; revoke an identity; query the CA database |
| `Dockerfile` | A docker specification to help user create Fabric ca client toolkit Docker image |
| `fabric-ca-client-config.yaml` | A configuration file to help you set the necessary attributed to enable the Fabric CA client to talk to the CA server |

# How-to

1. Navigate to [reference dev network](../reference/networks/dev)
2. Look at the set of `fabric-ca-client/scripts` and modify accordingly
3. Run the command `caClientOps.sh cli`, this will open a shell 
