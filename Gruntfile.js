(function() {
  module.exports = function(grunt) {
    grunt.initConfig({
      pkg: grunt.file.readJSON("package.json"),
      watch: {
        clean: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["clean"]
        },
        coffee: {
          files: "**/*.coffee",
          tasks: ["coffee:compile"]
        },
        compass: {
          files: "**/*.scss",
          tasks: ["compass"]
        },
        cssmin: {
          files: ["**/*.scss"],
          tasks: ["cssmin"]
        },
        uglify: {
          files: ["**/*.coffee"],
          tasks: ["uglify"]
        }
      },
      clean: ["" + __dirname + "/styles", "" + __dirname + "/scripts", "" + __dirname + "/public/server.js"],
      coffee: {
        compile: {
          files: {
            "Gruntfile.js": "src/Gruntfile.coffee",
            "public/server.js": "src/server.coffee",
            "scripts/app.js": ["src/scripts/*.coffee"]
          }
        }
      },
      compass: {
        dist: {
          options: {
            sassDir: "" + __dirname + "/src/styles/",
            cssDir: "" + __dirname + "/styles/"
          }
        }
      },
      cssmin: {
        build: {
          files: {
            "styles/min/main.min.css": ["" + __dirname + "/styles/*.css"]
          }
        }
      },
      uglify: {
        dist: {
          files: {
            "scripts/min/app.min.js": ["" + __dirname + "/scripts/*.js"]
          }
        }
      },
      connect: {
        server: {
          options: {
            port: 8080,
            hostname: "*",
            base: "./public",
            livereload: true,
            onCreateServer: function(server, connect, options) {
              var watchdog;
              watchdog = require("./public/server.js");
              watchdog.listen(8000);
              return grunt.log.writeln("Listening port " + options.port);
            }
          }
        }
      }
    });
    grunt.loadNpmTasks("grunt-contrib-clean");
    grunt.loadNpmTasks("grunt-contrib-coffee");
    grunt.loadNpmTasks("grunt-contrib-compass");
    grunt.loadNpmTasks("grunt-contrib-cssmin");
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-contrib-connect");
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.registerTask("default", ["clean", "coffee", "compass", "cssmin", "uglify", "connect", "watch"]);
  };

}).call(this);
