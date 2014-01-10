_ = require 'underscore'

exports.Content = (app) ->

  index: (req, res) ->
    return res.render 'index', title: 'Express City'

  tuplespace: (req, res) ->
    [name, params] = req.params
    params = _(params.split('/')).reject (i) ->
      i?.length < 1
    tuple = {}
    while params.length > 1
      [k,v] = params.splice(0, 2)
      tuple[k] = v
    return res.render 'tuplespace', name: name, tuple: tuple
