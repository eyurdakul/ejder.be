grunt = require "grunt"

class WebSocket
  constants :
    STATUS_CONNECTION: "connection"
    STATUS_ERROR: "error"

  constructor: ()->
    @config = grunt.config.data.connect.use_socket_io
    @socketio = @config.socketio
    @socketio.sockets.on @constants.STATUS_CONNECTION @onConnection

  onConnection: (socket)->
    socket.emit "test", message: "hello"

module.exports = WebSocket
