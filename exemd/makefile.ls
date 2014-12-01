#!/usr/bin/env lsc 

{ parse, add-plugin } = require('newmake')

name            = "_site"
destination-dir = "#name"
source-dir      = "assets"

s = -> "#source-dir#it"
d = -> "#destination-dir#it"

{baseUrl} = require('./site.json')


parse ->



    @add-plugin 'jadeBeml',(g, deps) ->

        substitute = (filename, tag) ->
            "stupid-replace #tag -f #filename"

        jade = ->
            "jade -O ./site.json -P -p #{it.orig-complete} | beml-cli "

        cmd = -> 
            ops = 
                "cat #{it.orig-complete} "
                jade(it)
                substitute('./assets/example.html', '{{include}}')
                substitute('./assets/usage.html', '{{usage}}')
            return ops * ' | ' + " > #{it.build-target} "

        @compile-files( cmd, ".html", g, deps )

    @notifyStrip destination-dir 

    @serveRoot './_site'

    @collect "all", -> [
        @notify ~>
            @toDir d("/css"), { strip: s("/less") }, ->
                @less s("/less/client.less"), s("/less/*.less")


        @notify ~>
            @toDir d(""), { strip: s("") }, -> [
                    @jadeBeml s("/index.jade"), s("/example.html")
                    ]

        @notify ~>
            @toDir d(""), { strip: s("") }, ->
                       @browserify s("/js/client.ls"), s("/js/*.{ls,js}")
        ]

    @collect "deploy", -> 
        @command-seq -> [
            @make "all"
            @cmd "blog-ftp-cli -l #name -r #baseUrl"
            ]
    @collect "update-docs", -> [
            @cmd "exemd ../test/x.md > ./assets/example.html"
            @cmd "pandoc ../docs/tool-usage.md > ./assets/usage.html"
            ]

    @collect "complete", ->
        @command-seq -> [
            @make "update-docs"
            @make "all"
            ]

    @collect "clean", -> [
        @remove-all-targets()
        @cmd "rm -rf #name"
    ]



        

