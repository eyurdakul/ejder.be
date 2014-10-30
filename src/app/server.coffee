express = require "express"
http = require "http"
jade = require "jade"
io = require "socket.io"

class Bootstrap
  _self = @
  data:
    constants:
      DEFAULT_ENCODING: "UTF8"
    routes:
      DEFAULT_PATH: "/"
    templates:
      MAIN_TEMPLATE: "index.jade"
      NOTFOUND_TEMPLATE: "404.jade"
    options:
      templatePath: "src/templates/"
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"

  constructor: ->
    @app = express()
    @server = http.createServer @app
    @app.configure = @config()
    @app.get @data.routes.DEFAULT_PATH, @loadMain
    @app.listen 8080

  config: ->
    @app.use "/public", express.static("#{__dirname}/../public")
    @app.use "/bower_components", express.static("#{__dirname}/../bower_components")

  loadMain: (request, response)->
    data = jade:
      pretty: true
      title: "Ejder Yurdakul 2014"
    content = jade.renderFile "../src/templates/index.jade", data
    response.end content

  loadContent: (template)->
    jade.renderFile Bootstrap.options.templatePath+Bootstrap.data.templates[template], Bootstrap.data.jade


new Bootstrap()