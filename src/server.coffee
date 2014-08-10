http = require "http"
jade = require "jade"

class Site
  data:
    options:
      tempPath: "src/templates/"
      tempExt: ".jade"
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"

  constructor: (route)->
    @init route
    return

  init: (route)->
    file = @data.options.tempPath+route+@data.options.tempExt
    @response = jade.renderFile file, @data.jade
    return

onHttpRequest = (request, response)->
  response.writeHead 200, "Content-Type":"text/html"
  route = "index"
  html = new Site route
  response.end html.response
  return
module.exports = http.createServer onHttpRequest