express = require "express"
http = require "http"
jade = require "jade"
io = require "socket.io"

class Bootstrap
  _self = Bootstrap.prototype
  routes:
    DEFAULT_PATH: "/"
    DATA_PATH: "/get/:model"
  options:
    templatePath: "#{__dirname}/../src/templates"
    modelPath: "#{__dirname}/../private/models"
    contentPath: "#{__dirname}/../public"
    libraryPath: "#{__dirname}/../bower_components"
    port: 8080

  constructor: ->
    @app = express()
    @server = http.createServer @app
    @app.use "/public", express.static(@options.contentPath)
    @app.use "/bower_components", express.static(@options.libraryPath)
    @app.set "views", @options.templatePath
    @app.set "view engine", "jade"
    @app.engine "jade", jade.__express
    @app.get @routes.DEFAULT_PATH, @load("index")
    @app.get @routes.DATA_PATH, @get()

    @io = io.listen @app.listen @options.port
    #TODO lazy loading
    @io.sockets.on "connection", (socket)->
      socket.emit "hello", planet : "world"

  load: (page)->
    return (request, response)->
      response.render page, require(_self.options.modelPath+"/"+page)

  get: ()->
    return (request, response)->
      model = request.param "model"
      response.json require(_self.options.modelPath+"/"+model)

  this

new Bootstrap()