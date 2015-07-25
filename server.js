// make sure to download express
// npm install -g express
// to run type 'node server.js' into the command line
// in the browser go to https://localhost
//no port 8000 needed anymore

var express = require('express');
var https = require('https');
var http = require('http');
var fs = require('fs');
var path = require('path');

// This line is from the Node.js HTTPS documentation.
var options = {
  key: fs.readFileSync('./server/key.key'),
  cert: fs.readFileSync('./server/crt.crt')
};

// Create a service (the app object is just a callback).
var app = express();

// Create an HTTP service.
http.createServer(app).listen(80);
// Create an HTTPS service identical to the HTTP service.
https.createServer(options, app).listen(443);

app.use(express.static(__dirname));
