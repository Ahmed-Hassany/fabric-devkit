# Introduction

Please refer to [Fabric CA User's Guide](https://hyperledger-fabric-ca.readthedocs.io/en/latest/users-guide.html#enrolling-the-bootstrap-identity).

# Content

The [scripts](./scripts) simulates:

* registration of an identity after a failed enrollment;

* registration of an identity after a successful enrollment of a client;

* revokation of an identity.

# How to use this test

To run execute the script follow these steps:

STEP 1: Ensure that fabric-ca-server is running. Run `./test.sh reset`, to ensure that you get a clean test environment, then run `./test.sh start` to get a running client and server.

STEP 2: Run the command `./test.sh cli` to access the client-cli container terminal.

STEP 3: In client-cli terminal, execute the command `./scripts/<name of script you wish to run>`.
