# make sure to download express
# npm install -g express
# to run type 'node server.js' into the command line
# in the browser go to https://localhost:8000 or http://localhost

express = require 'express'
https = require 'https'
http = require 'http'
fs = require 'fs'

options =
  key: fs.readFileSync './server/key.key'
  cert: fs.readFileSync './server/crt.crt'

app = express();

http.createServer(app).listen(80)
https.createServer(options, app).listen(8000)

app.use express.static __dirname


# superagent
#   .get('http://kotaku.com/an-album-a-minecraft-style-game-both-1625202335')
#   .end(function(res) {
#     console.log(summarize(res.text));
#   });