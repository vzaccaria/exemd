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
            "sed -e '/#tag/r #filename'"

        jade = ->
            "jade -O ./site.json -P -p #{it.orig-complete} < #{it.orig-complete} | beml-cli "

        cmd = -> 
            [ jade(it), substitute2('./assets/example.html', '<include>') ] * ' | ' + " > #{it.build-target} "

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

    @collect "clean", -> [
        @remove-all-targets()
        @cmd "rm -rf #name"
    ]



        

