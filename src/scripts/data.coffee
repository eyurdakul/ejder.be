console.log "data file is generated"
socket = io "http://localhost:8080"
socket.on "hello", (data)->
  console.log data