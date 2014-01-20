_ = require 'underscore'

exports.Content = (app) ->

  index: (req, res) ->
    return res.render 'index', title: 'Node Linda Base'

  tuplespace: (req, res) ->
    name = req.params.tuplespace
    tuple = req.query

    args = {
      name: name,
      tuple: tuple,
      title: "#{name} / #{JSON.stringify(tuple)}"
    }

    return res.render 'tuplespace', args
