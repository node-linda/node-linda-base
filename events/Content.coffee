exports.Content = (app) ->

  index: (req, res) ->
    return res.render 'index', title: 'Express City'
