(function() {
  var Router, fs, http, jade, onHttpRequest, url;

  http = require("http");

  jade = require("jade");

  url = require("url");

  fs = require("fs");

  Router = (function() {
    Router.prototype.data = {
      constants: {
        DEFAULT_ENCODING: "UTF8",
        DEFAULT_ROUTE: "/index",
        MAIN_TEMPLATE: "index.jade",
        NOTFOUND_TEMPLATE: "404.jade",
        ROOT: "/",
        REQ_TYPE_AJAX: "x-requested-with",
        REQ_VAL_AJAX: "XMLHttpRequest"
      },
      options: {
        tempPath: "src/templates/"
      },
      jade: {
        pretty: true,
        title: "Ejder Yurdakul 2014"
      }
    };

    function Router(request, response) {
      this.request = request;
      this.response = response;
      return this.init();
    }

    Router.prototype.init = function() {
      var content, file, resolved_url, route;
      this.request.setEncoding(this.data.constants.DEFAULT_ENCODING);
      if (this.isAjax()) {

      } else {
        resolved_url = url.parse(this.request.url);
        route = resolved_url.pathname;
        switch (route) {
          case "/":
            file = this.data.options.tempPath + this.data.constants.MAIN_TEMPLATE;
            this.response.setHeader("Content-Type", "text/html");
            this.response.end(jade.renderFile(file, this.data.jade));
            break;
          case "/css":
            content = fs.readFileSync("" + __dirname + "/styles/min/main.min.css");
            this.response.setHeader("Content-Type", "text/css");
            this.response.end(content);
            break;
          case "/js":
            content = fs.readFileSync("" + __dirname + "/scripts/min/app.min.js");
            this.response.setHeader("Content-Type", "application/javascript");
            this.response.end(content);
            break;
          default:
            file = this.data.options.tempPath + this.data.constants.NOTFOUND_TEMPLATE;
            this.response.end(jade.renderFile(file, this.data.jade));
        }
      }
    };

    Router.prototype.isAjax = function() {
      var _ref;
      return (((_ref = this.request.headers) != null ? _ref[this.data.constants.REQ_TYPE_AJAX] : void 0) != null) === this.data.constants.REQ_VAL_AJAX;
    };

    return Router;

  })();

  onHttpRequest = function(request, response) {
    return new Router(request, response);
  };

  module.exports = http.createServer(onHttpRequest);

}).call(this);
