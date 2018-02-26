path = require "path"

module.exports = (grunt)->

  isDev = grunt.cli.tasks[0] is "dev"
  forever_options = if isDev then "-d -v" else "-a -o ./logs/out.log -e ./logs/err.log"

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    watch:
      style:
        files: ["**/*.scss"]
        tasks: ["clean:style", "clean:media", "copy", "compass", "cssmin"]
      frontjs:
        files: ["#{__dirname}/src/scripts/**/*.coffee"]
        tasks: ["clean:script:front", "coffee:front", "copy"]
      backjs:
        files: ["#{__dirname}/src/app/**/*.coffee"]
        tasks: ["clean:script:back", "coffee:back", "exec:restart_server"]
      content:
        files: ["#{__dirname}/src/app/data/**/*.json"]
        tasks: ["copy:content"]
      media:
        files: ["#{__dirname}/src/media/**/*.*"]
        tasks: ["clean:media", "copy:media"]
    clean:
      all: ["#{__dirname}/frontend/*", "#{__dirname}/backend/*"]
      style: ["#{__dirname}/frontend/styles/*"]
      script:
        front: ["#{__dirname}/frontend/scripts/*"]
        back: ["#{__dirname}/backend/*"]
      media: ["#{__dirname}/frontend/media/*"]
      sources: ["#{__dirname}/frontend/styles/*.css", "#{__dirname}/frontend/scripts/all.js", "!#{__dirname}/frontend/styles/svg-only.css", "!#{__dirname}/frontend/styles/main.min.css"]
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
      media:
        files: [
          (
            expand: true
            cwd: "#{__dirname}/src/media/"
            src: ["*", "**"]
            dest: "#{__dirname}/frontend/media/"
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
            "#{__dirname}/src/scripts/controllers/*.coffee"
            "#{__dirname}/src/scripts/directives/*.coffee"
            "#{__dirname}/src/scripts/factories/*.coffee"
            "#{__dirname}/src/scripts/services/*.coffee"
            "#{__dirname}/src/scripts/app.coffee"
          ]
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
          "frontend/styles/main.min.css": ["#{__dirname}/frontend/styles/*.css", "!#{__dirname}/frontend/styles/svg-only.css"]
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
    exec:
      start_server: "forever start "+forever_options+" backend/server.js"
      restart_server: "forever restart "+forever_options+" backend/server.js"
      stop_server: "forever stopall"

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-wiredep"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-exec"

  grunt.registerTask "setEnv", "Switching to DEV environment", ->
    grunt.file.delete "dev" if grunt.file.exists "dev"
    console.log isDev
    console.log grunt.cli.tasks[0]
    if isDev
      console.log "DEV ENV"
      grunt.file.write "dev", "The existence of this file indicates the environment and ignored by git"

  grunt.registerTask "dev", ["setEnv", "exec:stop_server", "coffeelint", "clean:all", "copy", "coffee", "compass", "wiredep", "exec:start_server", "watch"]
  grunt.registerTask "dist", ["setEnv", "exec:stop_server", "clean:all", "copy", "coffee", "compass", "cssmin", "uglify", "wiredep", "clean:sources", "exec:start_server"]
  return