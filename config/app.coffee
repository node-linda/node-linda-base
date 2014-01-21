# Dependency

fs = require 'fs'
path = require 'path'
http = require 'http'
util = require 'util'
express = require 'express'
direquire = require 'direquire'
debug = require('debug')('coah')

# Environment

fs.exists path.resolve('config', 'env.json'), (exists) ->
  return unless exists
  for k, v of require path.resolve 'config', 'env.json'
    process.env[k.toUpperCase()] = v

# Application

app = exports.app = express()
app.disable 'x-powerd-by'
app.set 'events', direquire path.resolve 'app', 'events'
app.set 'helper', direquire path.resolve 'app', 'helper'
app.set 'views', path.resolve 'app', 'views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev' unless process.env.NODE_ENV is 'test'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static path.resolve 'public'

if process.env.NODE_ENV isnt 'production'
  app.use express.errorHandler()
  debug "using error handler"

# Routes

Content = (app.get 'events').Content app
app.get '/', Content.index
app.get '/:tuplespace', Content.tuplespace

server = exports.server = http.createServer app
io = require('socket.io').listen(server)
linda = require('linda-socket.io').Linda.listen(io: io, server: server);
