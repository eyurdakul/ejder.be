express = require "express"
http = require "http"
jade = require "jade"
fs = require "fs"

class Bootstrap
  _self = Bootstrap.prototype
  routes:
    DEFAULT_PATH: "/"
    DATA_PATH: "/get/:model"
  options:
    templatePath: "#{__dirname}/../src/templates"
    dataPath: "#{__dirname}/../private/data"
    contentPath: "#{__dirname}/../public"
    libraryPath: "#{__dirname}/../bower_components"
    port: 8080

  constructor: ->
    @app = express()

    @app.use "/public", express.static(@options.contentPath)
    @app.use "/bower_components", express.static(@options.libraryPath)
    @app.set "views", @options.templatePath
    @app.set "view engine", "jade"
    @app.engine "jade", jade.__express

    @app.get @routes.DEFAULT_PATH, (request, response)->
      response.render "index"
    @app.get @routes.DATA_PATH, (request, response)->
      model = request.param "model"
      fs.readFile _self.options.dataPath+"/"+model+".json", (err, data)->
        throw err if err
        responseObject = JSON.parse data
        response.json responseObject
    @app.listen @options.port

  @

new Bootstrap()