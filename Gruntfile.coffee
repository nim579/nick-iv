module.exports = (grunt)->
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'node-srv'

    # Project configuration.
    grunt.initConfig
        jade:
            pages:
                files: [
                    expand: true
                    cwd: './templates'
                    src: ['./!(includes)*/*.jade', './*.jade']
                    dest: './build'
                    ext: '.html'
                ]

        copy:
            assets:
                files: [
                    expand: true
                    cwd: 'assets/'
                    src: ['images/**/*', 'other/**/*']
                    dest: 'build/static/'
                ,
                    expand: true
                    cwd: 'assets/root'
                    src: ['**/*']
                    dest: 'build/'
                ]

        less:
            dev:
                files:
                    "build/static/global.css": "assets/styles/global.less"

        coffee:
            scripts:
                options:
                    join: false
                    sourceMap: false
                    bare: true

                expand: true
                cwd: 'src'
                src: ['**/*.coffee']
                dest: './build/static/js/'
                ext: '.js'

        clean:
            pages: ['./build/**/*.html']
            assets: ['./build/static/images', './build/static/other', './build/!(*.html)']
            less: ['./build/static/global.css']
            coffee: ['./build/static/js']

            build: ['build']

        watch:
            pages:
                files: ['templates/**/*.jade']
                tasks: ['clean:pages', 'jade']

            assets:
                files: ['./assets/images/**/*', './assets/other/**/*', './assets/root/**/*']
                tasks: ['clean:assets', 'copy:assets']

            less:
                files: ['./assets/styles/**/*']
                tasks: ['less']

            coffee:
                files: ['./src/**/*.coffee']
                tasks: ['clean:coffee', 'coffee']

        srv:
            dev:
                root: './build'
                404: './build/404.html'


    grunt.registerTask 'default', 'Default task', ->
        grunt.log.ok 'Grunt file found'

    grunt.registerTask 'build', ['clean:build', 'less', 'jade', 'copy', 'coffee']

    grunt.registerTask 'dev', 'Init app for developing and start server', ->
        grunt.config.data.srv.dev.keepalive = false
        grunt.task.run ['build', 'srv:dev', 'watch']
