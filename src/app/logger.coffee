winston = require "winston"

class Logger
  _self = undefined

  isDev: undefined
  logFile: "error.log"
  CONSTANTS:
    LOG_DEBUG: "debug"
    LOG_WARNING: "warn"
    LOG_ERROR: "error"

  constructor: ->
    _self = @

    winston.add winston.transports.File, {filename: @logFile}

  init: (isDev)->
    if isDev
      winston.level = @CONSTANTS.LOG_DEBUG
    else
      winston.level = @CONSTANTS.LOG_WARNING
      winston.remove winston.transports.Console


  warning: (msg)->
    winston.log @CONSTANTS.LOG_WARNING, msg

  error: (msg)->
    winston.log @CONSTANTS.LOG_ERROR, msg

  debug: (msg)->
    winston.log @CONSTANTS.LOG_DEBUG, msg

  @

module.exports = new Logger()