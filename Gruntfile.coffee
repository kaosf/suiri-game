module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      base:
        expand: true
        cwd: 'coffee/'
        src: '**/*.coffee'
        dest: './'
        ext: '.js'
        options:
          bare: true
    simplemocha:
      options:
        reporter: 'spec'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'
    clean:
      app: 'app.js'
      routes: 'routes'

  grunt.registerTask 'default', ['clean', 'compile', 'test']
  grunt.registerTask 'compile', ['coffee:base']
  grunt.registerTask 'test', ['simplemocha:all']
  grunt.registerTask 'clean', ['clean:app', 'clean:routes']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-clean'
