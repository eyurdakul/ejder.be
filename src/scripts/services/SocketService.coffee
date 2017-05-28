"use strict"
SocketService = ["$log", ($log)->

  $log.debug "Creating SocketService"

  CONSTANTS =
    eventConnected: "connectionEstablished"

  socket = io.connect "/"
  socket.on CONSTANTS.eventConnected, (data)->
    $log.debug "Connection is established with the socket.io server on: "+data.datetime

  registerCallback = (event, callback)->
    socket.on event, callback

  emit = (event, data)->
    socket.emit event, data

  emit: emit
  registerCallback: registerCallback
]