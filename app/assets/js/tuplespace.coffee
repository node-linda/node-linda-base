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
  console.log msg
  $("#log").prepend $("<li>").text(JSON.stringify msg)

status = (msg) ->
  console.log msg
  $("#status").text "<socket.io #{msg}>"

$ ->
  $("#btn_write").click (e) ->
    ts.write tuple
