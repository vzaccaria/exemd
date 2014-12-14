
{docopt}             = require('docopt')
_                    = require('lodash')
{cat,mkdir,rm, exec} = require('shelljs')
v                    = require('verbal-expressions')
uid                  = require('uid')
Promise              = require('bluebird')
asyncrepl            = require('async-replace')

#module-path = "/usr/local/share/npm/lib/node_modules/"
module-path = ""

require! 'fs'


src = __dirname
cwd = process.cwd()

prepare = ->
    dirname = "#cwd/tmp#{uid(7)}"
    mkdir(dirname)
    return dirname


replace-code = (tmpdir, target-mode, m, lang, params, code, offset, string, done) -->

    {process} = require("#{module-path}exemd-#{lang}")
    opts = {}
    opts.target-mode = target-mode 
    opts.params = params
    opts.orig = m
    opts.tmpdir = tmpdir
    block = code

    process(block, opts)
    .then (-> done(null, it)), (-> done(it, null))


    # console.log p3

code-regex = v()
                .then("```")
                .anythingBut("{")
                .then("{")
                .beginCapture()
                .word()
                .endCapture()
                .anythingBut("!")
                .then("!")
                .beginCapture()
                .anythingBut("}")
                .endCapture()
                .then("}")
                .beginCapture()
                .anythingBut("```")
                .endCapture()
                .then("```")


match-array = []
promise-array = []

par = (regex, my-async-replace, string) -->
    let lstring = string
        new Promise (res, rej) ->
            asyncrepl lstring, regex, my-async-replace, (err, result) ->
                if lstring == result
                    rej(lstring)
                else
                    res(result)

promiseWhile = (init, action) ->
  val = init
  new Promise (res, rej) ->

      loop_ = ->
        action(it)
        .delay(1)
        .then loop_
        .caught res

      process.nextTick ( -> loop_(init) )

promised-replace = (regex, my-async-replace, string) ->
    promiseWhile string, par(regex, my-async-replace)


_module = ->

    process = (target-mode, text) ->

        tmpdir = prepare!

        convert = ->
            if target-mode == 'raw'
                return it
            else
                if target-mode == 'html' 
                    tmp-markdown = "#{tmpdir}/#{uid(7)}.md"
                    it.to(tmp-markdown)
                    
                    return new Promise (res, rej) ->
                        exec "pandoc -s #tmp-markdown", {+async, +silent}, (code, output) ->
                            rm('-rf', tmpdir)

                            if not code
                                res(output)
                            else
                                rej(output)
                else
                    return rej('unsupported') 


        promised-replace(code-regex, replace-code(tmpdir, target-mode), text)
        .then convert, ->
            rm('-rf', tmpdir)
            throw it

    iface = {
        process: process
    }


module.exports = _module()