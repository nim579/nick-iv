module.exports = (grunt)->
    
    # Project configuration.
    grunt.initConfig
        less:
            main:
                file: 'src/static/less/global.less'
                dest: 'src/static/css/global.css'
                path: 'src/static/'

        coffee:
            frontend:
                files: [
                    expand: true
                    cwd: 'src/static/coffee/'
                    src: ['*.coffee']
                    dest: 'src/static/js/'
                    ext: '.js'
                ]

        jade:
            pages:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['./!(includes)*/*.jade', './*.jade']
                    dest: 'src/'
                    ext: '.html'
                ]

        copy:
            js:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['static/js/**/*.js']
                    dest: 'build/'
                ]

            css:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['static/css/**/*.css']
                    dest: 'build/'
                ]

            files:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['./!(*.html|*.jade)*','static/images/**/*', 'static/b/**/!(*.less)']
                    dest: 'build/'
                    filter: 'isFile'
                ]

            pages:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['**/*.html']
                    dest: 'build/'
                ]

        clean:
            build:
                files: [
                    expand: true
                    cwd: 'build/'
                    src: ['*']
                ]

        watch:
            less:
                files: ['src/static/**/*.less']
                tasks: 'less'

            pages:
                files: ['src/pages/**/*.jade']
                tasks: 'jade:pages'

            coffee:
                files: ['src/static/coffee/**/*.coffee']
                tasks: 'coffee:frontend'

        srv:
            dev:
                root: './src'
                logs: true
                404: './src/404.html'

            build:
                root: './build'
                404: './build/404.html'


    path = require('path')
    less = require('less')
    jade = require('jade')

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'node-srv'


    grunt.registerTask 'default', 'Default task', ->
        grunt.log.ok 'Grunt file found'


    grunt.registerTask 'build', ['clean:build', 'coffee', 'less', 'jade', 'copy']


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


    grunt.registerMultiTask 'jade', 'Compile Jade files to HTML', ->
        for file, i in @files
            jadeCode = grunt.file.read file.src[0]
            compiled = jade.compile jadeCode, {filename: file.src[0]}

            html = compiled {}
            grunt.log.ok file.src[0]
            grunt.file.write file.dest, html


    grunt.registerMultiTask 'clean', 'Clean folders and files', ->
        for file, i in @files
            grunt.file.delete file.src[0]

        grunt.log.ok 'Cleaned!'



