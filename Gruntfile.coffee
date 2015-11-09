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
      style: ["#{__dirname}/public/styles/*"]
      script: ["#{__dirname}/public/scripts/*", "#{__dirname}/private/*"]
      media: ["#{__dirname}/public/media/*"]
    copy:
      build:
        files: [
          (
            expand: true
            cwd: "#{__dirname}/src/media/"
            src: ["*", "**"]
            dest: "#{__dirname}/public/media/"
          )
          (
            expand: true
            cwd: "#{__dirname}/src/app/data/"
            src: "*.json"
            dest: "#{__dirname}/private/data/"
          )
        ]
      content:
        files: [
          (
            expand: true
            cwd: "#{__dirname}/src/app/data/"
            src: "*.json"
            dest: "#{__dirname}/private/data/"
          )
        ]
    coffee:
      front:
        options:
          join: true
        files:
          "public/scripts/all.js":[
            "#{__dirname}/src/scripts/services/*.coffee"
            "#{__dirname}/src/scripts/directives/*.coffee"
            "#{__dirname}/src/scripts/controllers/*.coffee"
            "#{__dirname}/src/scripts/app.coffee"]
      back:
        expand: true
        flatten: false
        cwd: "#{__dirname}/src/app"
        src: ["**/*.coffee"]
        dest: "#{__dirname}/private/"
        ext: ".js"
    compass:
      build:
        options:
          sassDir: "#{__dirname}/src/styles/"
          cssDir: "#{__dirname}/public/styles/"
    cssmin:
      build:
        files:
          "public/styles/min/main.min.css":["#{__dirname}/public/styles/*.css"]
    uglify:
      build:
        files: [
          expand: true
          cwd: "#{__dirname}/public/scripts"
          src: "**/*.js"
          dest: "#{__dirname}/public/scripts/min"
        ]
    wiredep:
      build:
        src: [
          path.resolve "#{__dirname}/src/templates/partials/inc/vendor.jade"
        ]
        options:
          directory: "./bower_components"

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-wiredep"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.registerTask "default", ["clean", "copy", "coffee", "compass", "cssmin", "uglify", "wiredep", "watch"]
  return