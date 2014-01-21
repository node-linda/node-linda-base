debug = require('debug')('coah:events:content')
exports.Content = (app) ->

  index: (req, res) ->
    debug 'index'
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
