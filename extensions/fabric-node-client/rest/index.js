const log4js = require('log4js');
const logger = log4js.getLogger('FabricRESTFul');
logger.level = 'debug';

const express = require('express');
const app = express();
const bodyParser = require('body-parser');
// support parsing application/json type post data
app.use(bodyParser.json()); 
//support parsing of application/x-www-form-urlencoded post data
app.use(bodyParser.urlencoded({
    extended: false
}));

app.use((req, res, next) => {
    logger.debug('New request for %s', req.originalUrl);
    return next();
});

const http = require('http');

const port = 8080;

const server = http.createServer(app).listen(port, ()=>{});
logger.info('Server started at %s', port);
server.timeout = 240000;

const blockchain = require('./blockchain');

app.post('/register', async (req, res)=>{
  logger.debug('==================== ENROLL ==================');
  const adminName = req.body.adminName;
  const adminPassword = req.body.adminPassword;
  const registrantName = req.body.registrantName;

  logger.debug('Username is: ' + adminName);
  logger.debug('Password is: ' + adminPassword);
  logger.debug('Registrant is: ' + registrantName);

  let result = null;
  const clientObj = await blockchain.getClient(adminName, adminPassword);
  if (clientObj.success) {
    
    const registerUserObj = await blockchain.registerUser(clientObj.payload.client, clientObj.payload.enrolledUserObj, registrantName);
    console.log(registerUserObj);
    result = {
      success: 200,
      message: {
        registrantID: registrantName,
		    registrantSecret: registerUserObj.payload.registrantSecret
      }
    }

  }else{
    result = {
      success: 500,
      message: `Unable to register ${registrantName}`
    };
  }
  
  res.send(result);
  
});

app.post('/invoke', async (req, res) => {
	logger.debug('==================== INVOKE ON CHAINCODE ==================');

	var fcn = req.body.fcn;
	var args = req.body.args;

	logger.debug('fcn  : ' + fcn);
	logger.debug('args  : ' + args);

  const txIDString = await blockchain.invokeTransaction(fcn,args);
  logger.debug('Trx created : ' + txIDString);
  res.json({success: true, trxId: txIDString});
});

// Invoke transaction on chaincode on target peers
app.post('/query', async (req, res) => {
	logger.debug('==================== QUERY ON CHAINCODE ==================');

	var fcn = req.body.fcn;
	var args = req.body.args;

	logger.debug('fcn  : ' + fcn);
	logger.debug('args  : ' + args);

  const data = await blockchain.queryChaincode(fcn,args);
  logger.debug('data found : ' + data);
  res.json({success: true, data: data});
});

// Invoke transaction on chaincode on target peers
app.get('/blocks/:blockId', async (req, res) => {
	logger.debug('==================== QUERY ON CHAINCODE ==================');

  const blockId = req.params.blockId;

	logger.debug('blockId  : ' + blockId);

  const blockData = await blockchain.getBlockByNumber(blockId);
  logger.debug('Block found : ' + blockData);
  res.json({success: true, data: blockData});
});

// Invoke transaction on chaincode on target peers
app.get('/transactions/:trxHash', async (req, res) => {
	logger.debug('==================== QUERY ON CHAINCODE ==================');

  const trxHash = req.params.trxHash;

	logger.debug('trxHash  : ' + trxHash);

  const blockData = await blockchain.getBlockByHash(trxHash);
  logger.debug('Block found : ' + blockData);
  res.json({success: true, data: blockData});
});