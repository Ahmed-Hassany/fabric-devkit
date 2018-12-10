# Introduction

Hyperledger Fabric CA is an implementation of a Certificate Authority (CA) intended for a Fabric network.

This is a smoke test for developer to analyse the capabilities of fabric-ca-server.

# Content

In this repository you will find the following items:

| Item | Description |
| --- | --- |
| [fabric-ca-client](./fabric-ca-client) | Contains test scenarios based on interactions between two fabric CA cli tools: `fabric-ca-client` and `fabric-ca-server`|

# Fabric ca client test scenario

In this scenario we are using the `fabric-ca-client` cli, packaged in a container, interacting with `fabric-ca-server`, also packaged in a container.

--------------------                             --------------------
| fabric-ca-client | ---- {enroll, register} ---> | fabric-ca-server |
--------------------                             --------------------

* `fabric-ca-client` container includes scripts representing different enrollment and registration scenarios.

* `fabric-ca-server` container items described in [Fabric CA Server](https://hyperledger-fabric-ca.readthedocs.io/en/latest/users-guide.html#fabric-ca-server)

Please refer to [fabric-ca-client/README.md](./fabric-ca-client/README.md) for instruction on how to run test.