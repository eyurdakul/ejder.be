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
    coffee:
      expand: true
      flatten: true
      cwd: "#{__dirname}/src/"
      src: ["*.coffee"]
      dest: "scripts/"
      ext: ".js"
    compass:
      dist:
        options:
          sassDir: "#{__dirname}/src/styles/"
          cssDir: "#{__dirname}/styles/"

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.registerTask "default", ["coffee", "compass", "watch"]
  return