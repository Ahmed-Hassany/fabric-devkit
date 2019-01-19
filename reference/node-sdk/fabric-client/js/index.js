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

const port = process.env.PORT || 8080;

const server = http.createServer(app).listen(port, ()=>{});
logger.info('Server started at %s', port);
server.timeout = 240000;

app.get('/test', (req, res)=>{
    res.send({
        success: true,
        data: 'hello'
    })
});