util = require "util"
fs = require "fs"

class WebSocket

  _self = undefined

  socket: undefined
  options :
    dataPath: "#{__dirname}/../private/data"

  constants :
    STATUS_CONNECTION: "connection"
    STATUS_CONNECTED: "connectionEstablished"
    STATUS_ERROR: "error"
    STATUS_SUCCESS: "success"
    EVENT_QUERY: "query"
    EVENT_QUERY_ERROR: "queryError"
    EVENT_RESULT: "result"

  constructor: ->
    _self = @

  init: (io)->
    @io = io
    @io.on @constants.STATUS_CONNECTION, @onConnection

  onConnection: (socket)->
    _self.socket = socket
    _self.socket.emit _self.constants.STATUS_CONNECTED,
      datetime: new Date()

    _self.socket.on _self.constants.EVENT_QUERY, _self.onQuery

  onQuery: (data)->
    _self.onQueryError data if  not data.model
    fs.readFile _self.options.dataPath+"/"+data.model+".json", (err, content)->
      if err
        _self.onQueryError err, data.model
      else
        responseObject = JSON.parse content
        _self.socket.emit _self.constants.EVENT_RESULT,
          model: data.model
          response: responseObject
          status: _self.constants.STATUS_SUCCESS


  onQueryError: (data, model=undefined )->
    _self.socket.emit _self.constants.EVENT_QUERY_ERROR,
      model: model
      response: data
      status: _self.constants.STATUS_ERROR

  @

module.exports = new WebSocket()