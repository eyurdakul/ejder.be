http = require "http"
jade = require "jade"
url  = require "url"
fs   = require "fs"

class Router
  data:
    constants:
      DEFAULT_ENCODING: "UTF8"
      DEFAULT_ROUTE: "/index"
      MAIN_TEMPLATE: "index.jade"
      NOTFOUND_TEMPLATE: "404.jade"
      ROOT: "/"
      REQ_TYPE_AJAX: "x-requested-with"
      REQ_VAL_AJAX: "XMLHttpRequest"
    options:
      tempPath: "src/templates/"
    jade:
      pretty: true
      title: "Ejder Yurdakul 2014"

  constructor: (request, response)->
    @request = request
    @response = response
    return @init()

  init: ->
    @request.setEncoding @data.constants.DEFAULT_ENCODING
    if @isAjax()
      #controller action
    else
      resolved_url = url.parse @request.url
      route = resolved_url.pathname
      switch route
        when "/"
          file = @data.options.tempPath+@data.constants.MAIN_TEMPLATE
          @response.setHeader "Content-Type", "text/html"
          @response.end jade.renderFile file, @data.jade
        when "/css"
          content = fs.readFileSync "#{__dirname}/styles/min/main.min.css"
          @response.setHeader "Content-Type", "text/css"
          @response.end content
        when "/js"
          content = fs.readFileSync "#{__dirname}/scripts/min/app.min.js"
          @response.setHeader "Content-Type", "application/javascript"
          @response.end content
        else
          file = @data.options.tempPath+@data.constants.NOTFOUND_TEMPLATE
          @response.end jade.renderFile file, @data.jade
    return

  isAjax: ->
    (@request.headers?[@data.constants.REQ_TYPE_AJAX]? == @data.constants.REQ_VAL_AJAX)

onHttpRequest = (request, response)->
  new Router request, response

module.exports = http.createServer onHttpRequest