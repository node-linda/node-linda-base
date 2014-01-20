# Dependency

fs = require 'fs'
path = require 'path'
util = require 'util'
express = require 'express'
direquire = require 'direquire'

# Environment

fs.exists path.resolve('config', 'env.json'), (exists) ->
  return unless exists
  for k, v of require path.resolve 'config', 'env.json'
    process.env[k.toUpperCase()] = v

# Application

app = module.exports = ( ->
  app = express()
  app.disable 'x-powerd-by'
  app.set 'events', direquire 'events'
  app.set 'helper', direquire 'helper'
  app.set 'views', path.resolve 'views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  unless process.env.NODE_ENV is 'test'
    app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use (req, res, next) ->
    app.locals.pretty = process.env.NODE_ENV isnt 'production'
    app.locals.req = req
    app.locals.res = res
    return next()
  app.use app.router
  if process.env.NODE_ENV is 'production'
    app.use express.static path.resolve 'public'
  else
    app.use express.static path.resolve 'dist'
  app.use express.errorHandler()
  return app
)()

# Routes

( ->
  Content = (app.get 'events').Content app
  app.get '/', Content.index
  app.get '/:tuplespace', Content.tuplespace
)()

