(function() {
  var Router, http, jade, onHttpRequest;

  http = require("http");

  jade = require("jade");

  Router = (function() {
    Router.prototype.data = {
      constants: {
        DEFAULT_ENCODING: "UTF8",
        DEFAULT_ROUTE: "/index",
        MAIN_TEMPLATE: "index.jade",
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
      var file;
      this.request.setEncoding(this.data.constants.DEFAULT_ENCODING);
      if (this.isAjax()) {

      } else {
        file = this.data.options.tempPath + this.data.constants.MAIN_TEMPLATE;
        this.data.jade.route = this.request.url.pathname;
        this.response.end(jade.renderFile(file, this.data.jade));
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
