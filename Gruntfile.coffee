path = require "path"
module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    watch:
      style:
        files: ["**/*.scss"]
        tasks: ["clean:style", "clean:media", "copy", "compass", "cssmin"]
      script:
        files: ["**/*.coffee"]
        tasks: ["clean:script", "coffee", "uglify", "copy"]
      content:
        files: ["#{__dirname}/src/app/data/**/*.json"]
        tasks: ["copy:content"]
    clean:
      style: ["#{__dirname}/frontend/styles/*"]
      script: ["#{__dirname}/frontend/scripts/*", "#{__dirname}/backend/*"]
      media: ["#{__dirname}/frontend/media/*"]
      sources: ["#{__dirname}/frontend/styles/*.css", "#{__dirname}/frontend/scripts/all.js"]
    copy:
      build:
        files: [
          (
            expand: true
            cwd: "#{__dirname}/src/media/"
            src: ["*", "**"]
            dest: "#{__dirname}/frontend/media/"
          )
          (
            expand: true
            cwd: "#{__dirname}/src/app/data/"
            src: "*.json"
            dest: "#{__dirname}/backend/data/"
          )
        ]
      content:
        files: [
          (
            expand: true
            cwd: "#{__dirname}/src/app/data/"
            src: "*.json"
            dest: "#{__dirname}/backend/data/"
          )
        ]
    coffee:
      front:
        options:
          join: true
        files:
          "frontend/scripts/all.js":[
            "#{__dirname}/src/scripts/services/*.coffee"
            "#{__dirname}/src/scripts/directives/*.coffee"
            "#{__dirname}/src/scripts/controllers/*.coffee"
            "#{__dirname}/src/scripts/factories/*.coffee"
            "#{__dirname}/src/scripts/app.coffee"]
      back:
        expand: true
        flatten: false
        cwd: "#{__dirname}/src/app"
        src: ["**/*.coffee"]
        dest: "#{__dirname}/backend/"
        ext: ".js"
    coffeelint:
      app: [
        "#{__dirname}/src/app/*.coffee"
        "#{__dirname}/src/scripts/**/*.coffee"
      ]
      options:
        "max_line_length":
          "level":"ignore"
    compass:
      build:
        options:
          sassDir: "#{__dirname}/src/styles/"
          cssDir: "#{__dirname}/frontend/styles/"
    cssmin:
      build:
        files:
          "frontend/styles/min/main.min.css":["#{__dirname}/frontend/styles/*.css"]
    uglify:
      build:
        files: [
          expand: true
          cwd: "#{__dirname}/frontend/scripts"
          src: "**/*.js"
          dest: "#{__dirname}/frontend/scripts/min"
        ]
    wiredep:
      build:
        src: [
          path.resolve "#{__dirname}/src/templates/partials/inc/vendor.jade"
        ]
        options:
          directory: "./bower_components"
    forever:
      server:
        options:
          index: "#{__dirname}/backend/server.js"

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-wiredep"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-forever"

  grunt.registerTask "dev", ["coffeelint", "clean", "copy", "coffee", "compass", "wiredep", "forever:server:start", "watch"]
  grunt.registerTask "dist", ["clean", "copy", "coffee", "compass", "cssmin", "uglify", "wiredep", "clean:sources", "forever:server:start"]
  grunt.registerTask "stop", ["forever:server:stop"]
  return