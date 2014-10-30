express = require "express"
http = require "http"
jade = require "jade"
io = require "socket.io"

class Bootstrap
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

  construtor: ->
    @app = express()
    @server = http.createServer @app
    @app.configure = @config
    @app.get @data.routes.DEFAULT_PATH, @loadMain

  listen: (args...)->
    console.log "listening"
    @app.listen(args)

  use:(args...)->
    console.log "using"
    @app.use args

  config: ->
    @app.use express.static "#{__dirname}/public"
    @app.use express.static "#{__dirname}/bower_components"

  loadMain: (request, response)->
    response.end @loadContent "MAIN_TEMPLATE"

  loadContent: (template)->
    jade.renderFile @data.options.templatePath+@data.templates[template], @data.jade

  this

#mainApp = new Bootstrap
app = express()
server = http.createServer app
module.exports = server