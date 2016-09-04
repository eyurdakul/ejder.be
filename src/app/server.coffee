express = require "express"
http = require "http"
jade = require "jade"
path = require "path"

class Bootstrap
  _self = undefined
  routes:
    DEFAULT_PATH: "/"
    TEMPLATE_PATH: "/load/:model"
  options:
    templatePath: "#{__dirname}/../src/templates"
    isDev: "#{__dirname}/../src/app/dev"
    contentPath: "#{__dirname}/../public"
    libraryPath: "#{__dirname}/../bower_components"
    port: 8080
    socketPort: 400
    status:
      notFound: 404
  isDev: undefined

  constructor: ->
    _self = @
    @isDev = path.existsSync @options.isDev
    @app = express()

    @server = http.Server @app
    @server.listen @options.socketPort
    @io = require("socket.io")(@server)
    @socketConnector = require("./live.js")
    @logger = require("./logger.js")
    @logger.init @isDev

    @socketConnector.init @io

    @app.use "/public", express.static(@options.contentPath)
    @app.use "/bower_components", express.static(@options.libraryPath)
    @app.set "views", @options.templatePath
    @app.set "view engine", "jade"
    @app.engine "jade", jade.__express

    @app.get @routes.DEFAULT_PATH, (request, response)->
      appData =
        data:
          isDev: _self.isDev
      response.render "index", appData
    @app.get @routes.TEMPLATE_PATH, (request, response)->
      model = request.param "model"
      response.render model
    @app.use (request, response, next)->
      _self.logger.warning "404 Not Found!: " + request.originalUrl
      response.status(_self.options.status.notFound)
      appData =
        data:
          isDev : _self.isDev
          request: request
      response.render "404", appData
    @app.listen @options.port

  @

new Bootstrap()