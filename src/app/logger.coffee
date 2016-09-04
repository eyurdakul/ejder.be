winston = require "winston"

class Logger
  _self = undefined

  isDev: undefined
  logFile: "../error.log"
  CONSTANTS:
    LOG_DEBUG: "debug"
    LOG_WARNING: "warn"
    LOG_ERROR: "error"
    TYPE_STRING: "string"
    TYPE_OBJECT: "object"

  constructor: ->
    _self = @

    winston.add winston.transports.File, {filename: @logFile}

  init: (isDev)->
    if isDev
      winston.level = @CONSTANTS.LOG_DEBUG
    else
      winston.level = @CONSTANTS.LOG_WARNING
      winston.remove winston.transports.Console

  warning: (data)->
    winston.log @CONSTANTS.LOG_WARNING, data

  error: (data)->
    winston.log @CONSTANTS.LOG_ERROR, data

  debug: (data)->
    winston.log @CONSTANTS.LOG_DEBUG, data

  @

module.exports = new Logger()