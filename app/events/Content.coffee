debug = require('debug')('coah:events:content')
exports.Content = (app) ->

  index: (req, res) ->
    debug 'index'
    return res.render 'index', title: 'Node Linda Base'

  tuplespace: (req, res) ->
    name = req.params.tuplespace
    tuple = {}
    for k,v of req.query
      if typeof v is 'string' and /^([1-9]\d+|\d)(\.\d+)?$/.test v
        tuple[k] = v - 0
      else
        tuple[k] = v

    args = {
      name: name,
      tuple: tuple,
      title: "#{name} / #{JSON.stringify(tuple)}"
    }

    return res.render 'tuplespace', args
