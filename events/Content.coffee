_ = require 'underscore'

exports.Content = (app) ->

  index: (req, res) ->
    return res.render 'index', title: 'Node Linda Base'

  tuplespace: (req, res) ->
    [name, params] = req.params
    params = _(params.split('/')).reject (i) ->
      i?.length < 1
    tuple = {}
    while params.length > 1
      [k,v] = params.splice(0, 2)
      tuple[k] = v

    args = {
      name: name,
      tuple: tuple,
      title: "#{name} / #{JSON.stringify(tuple)}"
    }

    return res.render 'tuplespace', args
