console.log "data file is generated"
socket = io "http://localhost:8000"
socket.on "test", (data)->
  console.log data