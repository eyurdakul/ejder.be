###
class WebSocket
  constants :
    STATUS_CONNECTION: "connection"
    STATUS_ERROR: "error"

  constructor: (io)->
    @io = io
    @io?.sockets?.on @constants.STATUS_CONNECTION @onConnection

  onConnection: (socket)->
    socket.emit "test", message: "hello"

  getIo: ->
    @io

module.exports = new WebSocket(io)
###