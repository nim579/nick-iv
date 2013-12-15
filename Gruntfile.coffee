module.exports = (grunt)->
    
    # Project configuration.
    grunt.initConfig
        less:
            main:
                file: 'static/less/global.less'
                dest: 'static/css/global.css'
                path: 'static/'

        coffee:
            frontend:
                files: [
                    expand: true
                    cwd: ''
                    src: ['static/js/*.coffee']
                    dest: ''
                    ext: '.js'
                ]

        watch:
            less:
                files: ['static/**/*.less']
                tasks: 'less'

            coffee:
                files: ['static/js/**/*.coffee']
                tasks: 'coffee:frontend'

    path = require('path')
    less = require('less')

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'

    grunt.registerTask 'default', 'Default task', ->
        grunt.log.ok 'Grunt file found'

    grunt.registerMultiTask 'less', 'Compile less files', ->
        done = @async()

        parser = new(less.Parser)(
            paths: @data.path
            filename: path.basename @data.file
        )

        parser.parse grunt.file.read(this.data.file), (e, tree)=>
            if e?
                grunt.log.error "Compile error: #{e.message} in file #{e.filename} at line #{e.line}"
                done()
                return

            css = tree.toCSS { compress: true }

            grunt.file.write @data.dest, css
            grunt.log.ok 'LESS compiled at ' + grunt.template.today()
            done()