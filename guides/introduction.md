# How to use Aladdin's Fabric Developers' Kit

Aladdin's Fabric Developers' Kit (or Fabric Devkit) is a toolbox to help developer create Fabric apps and platform engineers to appreciate the process involved in spinning up a working Fabric network. 

For the purpose of this user guide, we shall use the term 'developer' as a catch-all term to refer to application developers and platform engineers.

## <a name="prerequisite">Prerequisite</a>

This DevKit is available only on macOS and Linux. If you are using Windows, please install a Linux VM.

To use this DevKit please follow these steps:

1. Install docker (see [installation guide](https://docs.docker.com/install/)).
   * Please familiarise yourself with [docker cli](https://docs.docker.com/get-started/).
2. Install Go.
   * For macOS, we recommed using [homebrew](https://brew.sh/).
   * For other platforms please refer to this [installation guide](https://golang.org/doc/install#install).
   * Additional steps:
      * Please also ensure that you also install C++ compiler. Refer to your respective platform documentation for instructions.
      * On Ubuntu you may also need to install a library call ltdl (please refer to apt-get install ltdl-dev).
3. Set the environmental variable GOPATH to a reference a directory to host your Go source codes and binaries (i.e. Go workspace). For example,
    ```
    export GOPATH=$HOME/go-projects
    ```
4. Navigate to the $GOPATH directory and install a Go application call [Govendor](https://github.com/kardianos/govendor) by executing this command:
    ```
    go get -u github.com/kardianos/govendor
    ```
    At the completion of the command, you will find in $GOPATH three directories:
    ```
    drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 bin
    drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 pkg
    drwxr-xr-x  3 <userid>  <groupid>  102  3 Feb 15:44 src
    ```
    This structure is dictated by Go tooling and will be your primary workspace for organising your chaincodes and and other dependencies such as third parties codes, tooling extensions, etc.

    In the context of chaincode development, you will be working mainly with Go sources. Hence, you only need to concern yourself with organising stuff within src directory.

    Additional notes for this step:

    * This step is not strictly needed. You could have create the workspace directories manually.
    * Govendor is a package or dependency management tool. It is one of many tools you can use to manage Go dependencies. The choice of Govendor is purely based on familarity. You could elect to install [other tools](https://github.com/golang/go/wiki/PackageManagementTools)).
5. Run the command to download this DevKit:
   ```
   go get -d github.com/workingwithblockchain/fabric-devkit
   ```
   At the completion of this command, you will see a message similar to this:
   ```
   package github.com/workingwithblockchain/fabric-devkit: no buildable Go source files in /Users/blockchain/workspace/misc/src/github.com/hyperledger/fabric
    ```
   There is no need to worry. Go tooling typically pull source code and then tries to build a binary but in this case the hyperledger fabric dependencies have nothing to be built.

   If you wish to ensure that the dependencies have been pulled down, simply navigate to $GOPATH/src/github.com and if you see the directory hyperledger it means that dependencies have been downloaded.
6. Get the Fabric dependencies (the framework to support your chaincode developmemnt) by issuing the following commands:
   ```
   go get -d github.com/hyperledger/fabric
   ```
   You should see similar message as in step 5.

## Content

1. [Minimal Go chaincodes](./chaincodes.md) - Describe the purpose and Go chaincode programming.
2. [Cryptogen and configtxgen lab](./crypto-configtx.md) - A lab to help you experiment with cryptogen and configtxgen tools to create cryptographic and channel artefacts. 
3. [fabric-ca](./fabric-ca.md) - A lab to help you experiment with the inner workings of Fabric CA. 
4. [networks](./networks.md) - Reference Fabric networks to support your application creation effort.
5. [node-sdk](./node-sdk.md) - A lab to help you experiment with Fabric node SDKs. 

> Note:
> 1. The toolkit uses out-of-the-box open source Fabric components to help developers spin-up a working Fabric networks and create apps. It does not imply that the examples presented in this kit necessarily represents production ready use cases. These are intended only to present concepts.
> 2. Hyperledger Fabric is an evolving blockchain platform. This DevKit does not necessary represents all aspects of Fabric. However, it represents components that are sufficient to spin-up a working network.