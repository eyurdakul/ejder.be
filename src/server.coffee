http = require "http"
jade = require "jade"

class Router
  data:
    constants:
      DEFAULT_ENCODING: "UTF8"
      DEFAULT_ROUTE: "/index"
      MAIN_TEMPLATE: "index.jade"
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
      file = @data.options.tempPath+@data.constants.MAIN_TEMPLATE
      @data.jade.route = @request.url.pathname
      @response.end jade.renderFile file, @data.jade
    return

  isAjax: ->
    (@request.headers?[@data.constants.REQ_TYPE_AJAX]? == @data.constants.REQ_VAL_AJAX)

onHttpRequest = (request, response)->
  new Router request, response

module.exports = http.createServer onHttpRequest