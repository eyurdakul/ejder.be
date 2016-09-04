fs = require "fs"
logger = require "./logger"

class WebSocket

  _self = undefined

  socket: undefined
  options :
    dataPath: "#{__dirname}/../private/data"
    fileRegexp : /[a-zA-Z]+.json/

  constants :
    STATUS_CONNECTION: "connection"
    STATUS_CONNECTED: "connectionEstablished"
    STATUS_ERROR: "error"
    STATUS_SUCCESS: "success"
    EVENT_QUERY: "query"
    EVENT_RESULT: "result"
    EVENT_UPDATE: "update"
    EVENT_CHANGE: "change"
    EVENT_EXCEPTION: "clientSideException"

  constructor: ->
    _self = @

  init: (io)->
    @io = io
    @io.on @constants.STATUS_CONNECTION, @onConnection
    fs.readdir @options.dataPath, (error, files)->
      if error
        logger.error error.toString()
      files.forEach (file)->
        fullPath = _self.options.dataPath + "/" + file
        if fs.statSync(fullPath).isFile() and file.match _self.options.fileRegexp
          fs.watchFile fullPath, ->
            logger.debug fullPath+" is changed"
            modelName = file.substring 0, file.indexOf(".")
            _self.io.emit _self.constants.EVENT_UPDATE,
              model: modelName

  onConnection: (socket)->
    _self.socket = socket
    _self.socket.emit _self.constants.STATUS_CONNECTED,
      datetime: new Date()

    _self.socket.on _self.constants.EVENT_QUERY, _self.onQuery
    _self.socket.on _self.constants.EVENT_EXCEPTION, _self.onException

  onQuery: (data)->
    if not data.model
      logger.error data
      return false
    fs.readFile _self.options.dataPath+"/"+data.model+".json", (err, content)->
      status = undefined
      if err
        logger.error err
        status = _self.constants.STATUS_ERROR
        responseObject = {}
      else
        status = _self.constants.STATUS_SUCCESS
        responseObject = JSON.parse content

      _self.socket.emit _self.constants.EVENT_RESULT,
        model: data.model
        response: responseObject
        status: status

  onException: (data)->
    logger.error JSON.stringify data

  @

module.exports = new WebSocket()