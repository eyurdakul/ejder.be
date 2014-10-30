(function() {
  var path;

  path = require("path");

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
            "public/scripts/app.js": ["src/scripts/*.coffee"],
            "Gruntfile.js": "src/Gruntfile.coffee"
          }
        },
        app: {
          expand: true,
          flatten: false,
          cwd: "" + __dirname + "/src/app",
          src: ["**/*.coffee"],
          dest: "" + __dirname + "/private/",
          ext: ".js"
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
          src: [path.resolve("/src/templates/partials/inc/vendor.jade")],
          options: {
            directory: "./bower_components"
          }
        }
      },
      express: {
        server: {
          options: {
            port: 8080,
            bases: ["" + __dirname + "/public", "" + __dirname + "/bower_components"],
            server: "" + __dirname + "/private/server.js",
            debug: true
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
    grunt.loadNpmTasks("grunt-express");
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.registerTask("default", ["clean", "copy", "coffee", "compass", "spritely", "cssmin", "uglify", "wiredep", "express", "express-start", "watch"]);
  };

}).call(this);
