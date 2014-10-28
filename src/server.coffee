http = require "http"
jade = require "jade"
url  = require "url"
fs = require "fs"
statics = require "node-static"

class Router
  data:
    constants:
      DEFAULT_ENCODING: "UTF8"
      MAIN_TEMPLATE: "index.jade"
      NOTFOUND_TEMPLATE: "404.jade"
      DEFAULT_PATH: "/"
      STATUS_OK: 200
      STATUS_NOTFOUND: 400
      STATIC_DIR: "./public"
      VENDOR_DIR: "."
      CONTENT_HTML:
        "Content-type":"text/html"

    options:
      templatePath: "src/templates/"
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"

  constructor: (request, response)->
    @request = request
    @request.setEncoding @data.constants.DEFAULT_ENCODING
    @response = response
    @fileServer = new statics.Server @data.constants.STATIC_DIR
    @libServer = new statics.Server @data.constants.VENDOR_DIR
    return @init()

  init: ->
    resolved_url = url.parse @request.url
    route = resolved_url.pathname

    if route is @data.constants.DEFAULT_PATH
      @response.writeHead @data.constants.STATUS_OK, @data.constants.CONTENT_HTML
      @response.end @load("MAIN_TEMPLATE")
    else
      if fs.existsSync @data.constants.STATIC_DIR+route
        @fileServer.serve @request, @response
      else if fs.existsSync @data.constants.VENDOR_DIR+route
        @libServer.serve @request, @response
      else
        @response.writeHead @data.constants.STATUS_NOTFOUND, @data.constants.CONTENT_HTML
        @response.end @load("NOTFOUND_TEMPLATE")

  load: (template)->
    jade.renderFile @data.options.templatePath+@data.constants[template], @data.jade

onHttpRequest = (request, response)->
  new Router request, response

module.exports = http.createServer onHttpRequest