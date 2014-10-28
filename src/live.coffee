###
grunt = require "grunt"

class WebSocket
  socket = undefined
  constants =
    STATUS_CONNECTION: "connection"
    STATUS_ERROR: "error"

  constructor: (socket)->
    @socket = socket
    @socket.on @constants.STATUS_CONNECTION @onConnection

  onConnection: (socket)->
    socket.emit "test", message: @data

module.exports = WebSocket

###