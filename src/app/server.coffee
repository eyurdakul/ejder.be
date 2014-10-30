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
      templatePath: "#{__dirname}/../src/templates"
      contentPath: "#{__dirname}/../public"
      libraryPath: "#{__dirname}/../bower_components"
    settings:
      dev:
        port: 8080
      prod:
        port: 8080
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"

  constructor: ->
    @app = express()
    @server = http.createServer @app
    @app.configure = @config()
    @app.get @data.routes.DEFAULT_PATH, @load
    @io = io.listen @app.listen @data.settings.dev.port
    @io.sockets.on "connection", (socket)->
      socket.emit "hello", planet : "world"

  config: ->
    @app.use "/public", express.static(@data.options.contentPath)
    @app.use "/bower_components", express.static(@data.options.libraryPath)
    @app.set "views", @data.options.templatePath
    @app.set "view engine", "jade"
    @app.engine "jade", jade.__express

  load: (request, response)->
    response.render "index"

  loadContent: (template)->
    jade.renderFile Bootstrap.options.templatePath+Bootstrap.data.templates[template], Bootstrap.data.jade


new Bootstrap()