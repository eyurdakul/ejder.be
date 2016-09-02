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
    @app.get @routes.DATA_PATH, (request, response)->
      model = request.param "model"
      fs.readFile _self.options.dataPath+"/"+model+".json", (err, data)->
        throw err if err
        responseObject = JSON.parse data
        response.json responseObject

  getIo: ->
    @io

module.exports = new WebSocket(io)
###