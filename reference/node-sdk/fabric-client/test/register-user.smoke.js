const expect = require('chai').expect;

const path = require('path');
const fs = require('fs');

const FabricClient = require('fabric-client');

describe('register-user', ()=>{

    const networkConfig = path.join(__dirname, '..', 'network-config.yaml');
    const client = FabricClient.loadFromConfig(networkConfig);
    describe(`Given fabric client class and I instantatiate a client by loading the class with ${networkConfig}`, ()=>{
        it(`expects the instance to exists`, ()=>{
            expect(client).to.be.not.null;
        });
    });

    const clientConfig = path.join(__dirname, '..', 'org1.yaml');
    describe(`Using the instantiate client, I load it with ${clientConfig}`, ()=>{
        client.loadFromConfig(clientConfig);
        it(`expects the the client context attribute _adminSigningIdentity`, ()=>{
            expect(client._network_config._client_context._adminSigningIdentity).to.be.not.null;
        });
    });

    describe('Having loaded the instance with client configuration', ()=>{
        const keyvaluestore = '/tmp/fabric-client-kv-org1';
        context('and instantiating the credential store', async ()=>{
            await client.initCredentialStores();
            it(`expects the creation of key value store in ${keyvaluestore}`, ()=>{
                expect(fs.existsSync(keyvaluestore)).to.be.true;
            });
        });

    });

});