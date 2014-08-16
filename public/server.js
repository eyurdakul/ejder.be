(function() {
  var Router, http, jade, onHttpRequest, statics, url;

  http = require("http");

  jade = require("jade");

  url = require("url");

  statics = require("node-static");

  Router = (function() {
    Router.prototype.data = {
      constants: {
        DEFAULT_ENCODING: "UTF8",
        MAIN_TEMPLATE: "index.jade",
        NOTFOUND_TEMPLATE: "404.jade",
        REQ_TYPE_AJAX: "x-requested-with",
        REQ_VAL_AJAX: "XMLHttpRequest"
      },
      options: {
        tempPath: "src/templates/"
      },
      jade: {
        pretty: true,
        title: "Ejder Yurdakul 2014"
      },
      paths: ["/", "/contact", "/blog", "/skills", "/experience"]
    };

    function Router(request, response) {
      this.request = request;
      this.request.setEncoding(this.data.constants.DEFAULT_ENCODING);
      this.response = response;
      this.fileServer = new statics.Server("./public");
      return this.init();
    }

    Router.prototype.init = function() {
      var content, file, pathIndex, resolved_url, route;
      if (this.isAjax()) {

      } else {
        resolved_url = url.parse(this.request.url);
        route = resolved_url.pathname;
        pathIndex = this.data.paths.indexOf(route);
        if (pathIndex !== -1) {
          file = this.data.options.tempPath + this.data.constants.MAIN_TEMPLATE;
          this.data.jade.route = route;
          content = jade.renderFile(file, this.data.jade);
          this.response.end(content);
        } else {
          this.fileServer.serve(this.request, this.response);
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
