"use strict"
SocketService = ["$log", ($log)->

  CONSTANTS =
    connectionPort: ":400"
    protocolSuffix: "//"
    eventConnected: "connectionEstablished"

  socket = io.connect(location.protocol+CONSTANTS.protocolSuffix+location.hostname+CONSTANTS.connectionPort)
  socket.on CONSTANTS.eventConnected, (data)->
    $log.debug "Connection is established with the socket.io server on: "+data.datetime

  registerCallback = (event, callback)->
    socket.on event, callback

  emit = (event, data)->
    socket.emit event, data

  emit: emit
  registerCallback: registerCallback
]