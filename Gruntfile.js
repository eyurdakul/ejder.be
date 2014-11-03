(function() {
  var path;

  path = require("path");

  module.exports = function(grunt) {
    grunt.initConfig({
      pkg: grunt.file.readJSON("package.json"),
      watch: {
        style: {
          files: ["**/*.scss"],
          tasks: ["clean:style", "clean:media", "copy", "compass", "cssmin"]
        },
        script: {
          files: ["**/*.coffee"],
          tasks: ["clean:script", "coffee", "uglify"]
        }
      },
      clean: {
        style: ["" + __dirname + "/public/styles/*"],
        script: ["" + __dirname + "/public/scripts/*", "" + __dirname + "/private/*"],
        media: ["" + __dirname + "/public/media/*"]
      },
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
            "Gruntfile.js": "src/Gruntfile.coffee",
            "config/settings.js": "config/settings.coffee"
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
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.registerTask("default", ["clean", "copy", "coffee", "compass", "spritely", "cssmin", "uglify", "wiredep", "watch"]);
  };

}).call(this);
