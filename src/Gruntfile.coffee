module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    watch:
      coffee:
        files: "src/scripts/*.coffee"
        tasks: ["coffee:compile"]
      compass:
        files: "src/styles/*.scss"
        tasks: ["compass"]
    coffee: [
              (
               expand: true
               flatten: true
               cwd: "#{__dirname}/src/"
               src: ["*.coffee"]
               dest: "scripts/"
               ext: ".js"
              )
            ]
    compass:
      dist:
        options:
          sassDir: "#{__dirname}/src/styles/"
          cssDir: "#{__dirname}/styles/"
    bowercopy:
      options:
        srcPrefix: "bower_components"
      script:
        options:
          destPrefix: "scripts/vendor"
    connect:
      options:
        port: 8080
        open: true
        hostname: "localhost"

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-bowercopy"
  grunt.registerTask "default", ["coffee", "compass", "bowercopy", "watch", "connect"]
  return