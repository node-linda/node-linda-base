debug = require('debug')('coah:events:content')
exports.Content = (app) ->

  index: (req, res) ->
    debug 'index'
    return res.render 'index', title: 'pullreq test app'

  tuplespace: (req, res) ->
    name = req.params.tuplespace
    tuple = {}
    for k,v of req.query
      if typeof v is 'string' and /^([1-9]\d+|\d)(\.\d+)?$/.test v
        tuple[k] = v - 0
      else
        tuple[k] = v

    args = {
      req: req
      name: name,
      tuple: tuple,
      title: "#{name} / #{JSON.stringify(tuple)}"
    }

    return res.render 'tuplespace', args

  writeTuple: (req, res) ->
    res.header 'Access-Control-Allow-Origin', '*'
    res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
    res.header 'Access-Control-Allow-Headers', 'Content-Type'

    from = req.socket._peername.address
    name = req.params.tuplespace
    try
      tuple = JSON.parse req.body.tuple
    catch
      res.statusCode = 400
      return res.end 'Bad Request: invalid JSON'
    process.linda.tuplespace(name).write tuple, {from: from}
    res.end JSON.stringify tuple
