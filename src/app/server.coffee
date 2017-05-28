express = require "express"
jade = require "jade"
fs = require "fs"

class Bootstrap
  _self = undefined
  routes:
    DEFAULT_PATH: "/"
    TEMPLATE_PATH: "/load/:view"
    DIRECTIVE_PATH: "/directive/:template"
  options:
    templatePath: "#{__dirname}/../src/templates"
    isDev: "#{__dirname}/../dev"
    contentPath: "#{__dirname}/../frontend"
    libraryPath: "#{__dirname}/../bower_components"
    port: 80
    socketPort: 400
    status:
      notFound: 404
  isDev: undefined

  constructor: ->
    _self = @
    @isDev = fs.existsSync @options.isDev
    @app = express()

    @app.use "/frontend", express.static(@options.contentPath)
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
      view = request.param "view"
      response.render view
    @app.get @routes.DIRECTIVE_PATH, (request, response)->
      template = request.param("template").replace ".html", ""
      response.render "directives/"+template
    @app.use (request, response, next)->
      _self.logger.warning "404 Not Found!: " + request.originalUrl
      response.status(_self.options.status.notFound)
      appData =
        data:
          isDev : _self.isDev
          request: request
      response.render "404", appData

    @server = @app.listen @options.port
    @io = require("socket.io").listen @server

    @logger = require("./logger.js")
    @logger.init @isDev

    @socketConnector = require("./live.js")
    @socketConnector.init @io

  @

new Bootstrap()