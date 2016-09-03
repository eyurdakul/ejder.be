express = require "express"
http = require "http"
jade = require "jade"
path = require "path"

class Bootstrap
  _self = Bootstrap.prototype
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

  constructor: ->
    @app = express()

    @server = http.Server @app
    @server.listen @options.socketPort
    @io = require("socket.io")(@server)
    @socketConnector = require("./live.js")

    @socketConnector.init @io

    @app.use "/public", express.static(@options.contentPath)
    @app.use "/bower_components", express.static(@options.libraryPath)
    @app.set "views", @options.templatePath
    @app.set "view engine", "jade"
    @app.engine "jade", jade.__express

    @app.get @routes.DEFAULT_PATH, (request, response)->
      appData =
        data:
          isDev: path.existsSync _self.options.isDev

      response.render "index", appData
    @app.get @routes.TEMPLATE_PATH, (request, response)->
      model = request.param "model"
      response.render model
    @app.listen @options.port

  @

new Bootstrap()