socket = io.connect("#{location.protocol}//#{location.host}")
window.linda = new Linda().connect(socket)
window.ts = linda.tuplespace(name)

linda.io.on "connect", ->
  status("connecting")
  console.log "watch start - #{JSON.stringify tuple}"
  ts.watch tuple, (err, res) ->
    return if err
    print res.data

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
      console.log _tuple
      location.href = create_url(name, _tuple)
