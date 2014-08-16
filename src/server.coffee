http = require "http"
jade = require "jade"
url  = require "url"
statics = require "node-static"

class Router
  data:
    constants:
      DEFAULT_ENCODING: "UTF8"
      MAIN_TEMPLATE: "index.jade"
      NOTFOUND_TEMPLATE: "404.jade"
      REQ_TYPE_AJAX: "x-requested-with"
      REQ_VAL_AJAX: "XMLHttpRequest"
    options:
      tempPath: "src/templates/"
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"
    paths: ["/", "/contact", "/blog", "/skills", "/experience"]

  constructor: (request, response)->
    @request = request
    @request.setEncoding @data.constants.DEFAULT_ENCODING
    @response = response
    @fileServer = new statics.Server "./public"
    return @init()

  init: ->
    if @isAjax()
      #controller action
      #mvc/controller/action
    else
      resolved_url = url.parse @request.url
      route = resolved_url.pathname
      pathIndex = @data.paths.indexOf route
      if pathIndex != -1
        file = @data.options.tempPath+@data.constants.MAIN_TEMPLATE
        @data.jade.route = route
        content = jade.renderFile file, @data.jade
        @response.end content
      else
        @fileServer.serve @request, @response
    return

  isAjax: ->
    (@request.headers?[@data.constants.REQ_TYPE_AJAX]? == @data.constants.REQ_VAL_AJAX)

onHttpRequest = (request, response)->
  new Router request, response

module.exports = http.createServer onHttpRequest