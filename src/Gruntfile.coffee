module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    watch:
      clean:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["clean"]
      copy:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["copy"]
      coffee:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["coffee:compile"]
      uglify:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["uglify"]
      compass:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["compass"]
      cssmin:
        files: ["**/*.coffee", "**/*.scss"]
        tasks: ["cssmin"]
    clean: ["#{__dirname}/public/*"]
    copy:
      dist:
        files: [
          (
            expand: true
            filter: "isFile"
            src: ["#{__dirname}/src/assets/content/*"]
            dest: "#{__dirname}/public/assets/content/*"
          )
          (
            expand: true
            filter: "isFile"
            src: ["#{__dirname}/src/assets/fonts/*"]
            dest: "#{__dirname}/public/assets/fonts/*"
          )
          (
            expand: true
            filter: "isFile"
            src: ["#{__dirname}/src/assets/includes/*"]
            dest: "#{__dirname}/public/assets/includes/*"
          )
          (
            expand: true
            filter: "isFile"
            src: ["#{__dirname}/src/assets/vectoral/*"]
            dest: "#{__dirname}/public/assets/vectoral/*"
          )
        ]
    coffee:
      compile:
        files:
          "Gruntfile.js": "src/Gruntfile.coffee"
          "public/server.js": "src/server.coffee"
          "public/scripts/app.js":["src/scripts/*.coffee"]
    compass:
      dist:
        options:
          sassDir: "#{__dirname}/src/styles/"
          cssDir: "#{__dirname}/public/styles/"
    cssmin:
      build:
        files:
          "public/styles/min/main.min.css":["#{__dirname}/public/styles/*.css"]
          "public/styles/min/vendor.min.css":["bower_components/bootstrap/dist/css/bootstrap.css"]
    uglify:
      dist:
        files:
          "public/scripts/min/app.min.js":["#{__dirname}/public/scripts/*.js"]
          "public/scripts/min/vendor.min.js":["bower_components/jquery/dist/jquery.js", "bower_components/bootstrap/dist/js/bootstrap.js", "bower_components/modernizr/modernizr.js"]
    spritely:
      dist:
        options:
          destCSS: "#{__dirname}/public/styles/sprite.css"
          algorithm: "binary-tree"
          engine: "phantomjs"
        files:[
          src: ["#{__dirname}/src/assets/sprite/*.png"]
          dest: "#{__dirname}/public/assets/sprite/sprite.png"
        ]
    connect:
      server:
        options:
          port: 8080
          hostname: "*"
          base: "./public"
          onCreateServer: (server, connect, options)->
            watchdog = require "./public/server.js"
            watchdog.listen 8000
            grunt.log.writeln "Listening port "+options.port

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-spritely"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.registerTask "default", ["clean", "copy", "coffee", "compass", "spritely", "cssmin", "uglify", "connect", "watch"]
  return