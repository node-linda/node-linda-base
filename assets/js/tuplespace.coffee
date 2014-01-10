socket = io.connect("#{location.protocol}//#{location.host}")
window.linda = new Linda().connect(socket)
window.ts = linda.tuplespace(name)

socket.on "connect", ->
  console.log "watch start - #{JSON.stringify tuple}"
  ts.watch tuple, (err, res) ->
    return if err
    print res.data

window.print = (msg) ->
  console.log msg
  $("#log").prepend $("<li>").text(JSON.stringify msg)


$ ->
  console.log "tuplespace!!! #{name}"
