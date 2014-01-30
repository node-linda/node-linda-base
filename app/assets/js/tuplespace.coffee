Array.prototype.permutation = (count, callback) ->
  permut = (arr, result) ->
    if result.length == count
      callback result
      return
    for i,index in arr
      return if arr.length - index + result.length < count
      _arr = arr[(index+1)...(arr.length)]
      _result = result.concat()
      _result.push i
      permut _arr, _result
  permut @, []


class QueryManager
  constructor: ->
    @count = {}

  push: (tuple) ->
    kv = []
    for k,v of tuple
      if typeof v is 'string'
        kv.push "#{k}=#{v}"
    for n in [1..2]
      kv.permutation n, (items) =>
        key = items.join('&')
        unless @count[key]
          @count[key] = 1
        else
          @count[key] += 1

  suggest: ->
    count = {}
    for k,v of @count
      count[v+Math.random()] = k
    results = []
    for k in Object.keys(count)
      tuple = {}
      for kv in count[k].split('&')
        [_, k, v] = kv.match(/^([^=]+)=(.+)$/)
        tuple[k] = v
      results.push tuple
    return results


socket = io.connect("#{location.protocol}//#{location.host}")
window.linda = new Linda().connect(socket)
window.ts = linda.tuplespace(name)
window.query_manager = new QueryManager

linda.io.on "connect", ->
  status("connecting")
  console.log "watch start - #{JSON.stringify tuple}"
  ts.watch tuple, (err, res) ->
    return if err
    print res.data
    query_manager.push res.data

linda.io.on "disconnect", ->
  status("disconnected..")

print = (msg) ->
  $("#log").prepend $("<li>").text(JSON.stringify msg).fadeIn(300)

status = (msg) ->
  console.log msg
  $("#status").text "<socket.io #{msg}>"

create_url = (name, tuple) ->
  _url = "#{location.protocol}//#{location.host}/#{name}"
  query = ""
  for k,v of tuple
    if typeof v == 'number' or typeof v == 'string'
      query += "&" if query.length > 0
      query += "#{k}=#{v}"
  if query.length < 1
    return _url
  return "#{_url}?#{query}"

$ ->
  $("#btn_write").click (e) ->
    ts.write tuple

  $("#tuplespace").editable "click", (e) ->
    _name = e.value.replace(/\//g,'')
    e.target.html _name
    if _name != name
      location.href = create_url(_name, tuple)

  $("#tuple").editable "click", (e) ->
    try
      _tuple = JSON.parse e.value
    catch ex
      alert "invalid JSON - #{e.value}"
      e.target.html e.old_value
      return
    if JSON.stringify(_tuple) != JSON.stringify(tuple)
      location.href = create_url(name, _tuple)

  $('#suggest_box').hide()
  setTimeout suggest_query, 2000

suggest_query = (interval=2000)->
  tuples = query_manager.suggest()
  for i,index in tuples by -1
    tuples.splice index, 1 if JSON.stringify(i) == JSON.stringify(window.tuple)
  if tuples.length > 0
    $("#suggest_box").show()
    suggest_dom = $("#suggest").html('')
    for tuple,index in tuples[0...3]
      suggest_dom.append(if index is 0 then ' watch ' else ' or ').
      append(
        $('<a>').attr('href', create_url(name, tuple)).
        text(JSON.stringify tuple)
      )
  return unless typeof interval is 'number' and interval > 0
  setTimeout suggest_query, interval
