(function() {
  var Site, http, jade, onHttpRequest;

  http = require("http");

  jade = require("jade");

  Site = (function() {
    Site.prototype.data = {
      options: {
        tempPath: "src/templates/",
        tempExt: ".jade"
      },
      jade: {
        pretty: true,
        title: "Ejder Yurdakul 2014"
      }
    };

    function Site(route) {
      this.init(route);
      return;
    }

    Site.prototype.init = function(route) {
      var file;
      file = this.data.options.tempPath + route + this.data.options.tempExt;
      this.response = jade.renderFile(file, this.data.jade);
    };

    return Site;

  })();

  onHttpRequest = function(request, response) {
    var html, route;
    response.writeHead(200, {
      "Content-Type": "text/html"
    });
    route = "index";
    html = new Site(route);
    response.end(html.response);
  };

  module.exports = http.createServer(onHttpRequest);

}).call(this);
