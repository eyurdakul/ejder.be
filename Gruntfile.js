(function() {
  module.exports = function(grunt) {
    grunt.initConfig({
      pkg: grunt.file.readJSON("package.json"),
      watch: {
        clean: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["clean"]
        },
        copy: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["copy"]
        },
        coffee: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["coffee:compile"]
        },
        compass: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["compass"]
        },
        cssmin: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["cssmin"]
        },
        uglify: {
          files: ["**/*.coffee", "**/*.scss"],
          tasks: ["uglify"]
        }
      },
      clean: ["" + __dirname + "/public/*", "" + __dirname + "/private/*"],
      copy: {
        main: {
          files: [
            {
              expand: true,
              cwd: "" + __dirname + "/src/media/",
              src: ["*", "**"],
              dest: "" + __dirname + "/public/media/"
            }
          ]
        }
      },
      coffee: {
        compile: {
          files: {
            "Gruntfile.js": "src/Gruntfile.coffee",
            "private/server.js": "src/server.coffee",
            "private/live.js": "src/live.coffee",
            "public/scripts/app.js": ["src/scripts/*.coffee"]
          }
        }
      },
      compass: {
        dist: {
          options: {
            sassDir: "" + __dirname + "/src/styles/",
            cssDir: "" + __dirname + "/public/styles/"
          }
        }
      },
      cssmin: {
        build: {
          files: {
            "public/styles/min/main.min.css": ["" + __dirname + "/public/styles/*.css"]
          }
        }
      },
      uglify: {
        dist: {
          files: {
            "public/scripts/min/app.min.js": ["" + __dirname + "/public/scripts/*.js"]
          }
        }
      },
      spritely: {
        dist: {
          options: {
            destCSS: "" + __dirname + "/public/styles/sprite.css",
            algorithm: "binary-tree",
            engine: "phantomjs"
          },
          files: [
            {
              src: ["" + __dirname + "/src/sprite/*.png"],
              dest: "" + __dirname + "/public/sprite/sprite.png"
            }
          ]
        }
      },
      wiredep: {
        dist: {
          src: ["" + __dirname + "/src/templates/inc/vendor.jade"],
          options: {
            directory: "./bower_components",
            exclude: [],
            verbose: true
          }
        }
      },
      connect: {
        server: {
          options: {
            port: 8000,
            hostname: "*",
            socketio: true,
            onCreateServer: function(server, connect, options) {
              var watchdog;
              watchdog = require("./private/server.js");
              return watchdog.listen(8080);
            }
          }
        }
      }
    });
    grunt.loadNpmTasks("grunt-contrib-clean");
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.loadNpmTasks("grunt-contrib-coffee");
    grunt.loadNpmTasks("grunt-contrib-compass");
    grunt.loadNpmTasks("grunt-contrib-cssmin");
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-spritely");
    grunt.loadNpmTasks("grunt-wiredep");
    grunt.loadNpmTasks("grunt-connect-socket.io");
    grunt.loadNpmTasks("grunt-contrib-connect");
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.registerTask("default", ["clean", "copy", "coffee", "compass", "spritely", "cssmin", "uglify", "wiredep", "connect", "watch"]);
  };

}).call(this);
