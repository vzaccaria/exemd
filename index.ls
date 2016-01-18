{docopt}            = require('docopt')
_                   = require('lodash')
{cat,mkdir,rm,exec} = require('shelljs')
v                   = require('verbal-expressions')
uid                 = require('uid')
Promise             = require('bluebird')
asyncrepl           = require('async-replace')
debug               = require('debug')('exemd')
$                   = require('underscore.string')
uid = require("uid")
chalk = require('chalk')

#module-path = "/usr/local/share/npm/lib/node_modules/"
module-path = ""

require! 'fs'


src = __dirname
cwd = process.cwd()

prepare = ->
    dirname = "#cwd/tmp#{uid(7)}"
    mkdir(dirname)
    return dirname



get-block = (string) ->
    block = v().then("```")
              .anythingBut("}")
              .then("}")
              .beginCapture()
              .anythingBut("```")
              .endCapture()
              .then("```")
    mtch =  block.exec(string)
    if mtch?
        return { block: mtch[1] }
    else
        return undefined

get-header = (string) ->

    header = v().searchOneLine()
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

    mtch = header.exec(string)
    if mtch?
        return { language: mtch[1], params: mtch[2]}
    else
        return undefined

replace-handler-gen = (tmpdir, target-mode, code-block, offset, string, done) -->

    process        = {}
    language       = ""
    params         = {}
    block          = ""
    code-block-res = get-header(code-block)

    debug code-block
    debug code-block-res

    if not code-block-res?
        debug "Bailing out.."
        done(null, code-block)
        return
    else
        { language, params } := code-block-res

    block-res = get-block(code-block)

    if not block-res?
        done(null, code-block)
        return
    else
        { block } := block-res

    try
        debug "Trying language #language"
        debug "Original code #block"
        process := require("#{module-path}exemd-#{language}").process
    catch e
        debug "uff..: #e"
        done(code-block)
        return

    opts             = {}
    opts.target-mode = target-mode
    opts.params      = params
    opts.params.jparams    = {}
    try
         opts.params.jparams = JSON.parse("{ #{opts.params} }")
    catch e

    opts.orig        = code-block
    opts.tmpdir      = tmpdir

    plugin-template = (targets, block, opts) ->

        params ?= opts.params
        params ?= {}

        new Promise (resolve, preject) ->

            debug "Running template"
            debug targets
            debug opts.target-mode
            try
              if targets[opts.target-mode]?
                  temp-file = uid(7)
                  debug "Target mode: #{opts.target-mode}"
                  debug targets
                  cmd = targets[opts.target-mode].cmd(block, temp-file, opts.tmpdir, params)
                  debug cmd
                  exec cmd, {+async, +silent}, (code, output) ->
                      output = targets[opts.target-mode].output(temp-file, opts.tmpdir, output, params)
                      debug output
                      if not code
                          _msg("Generated image in #{opts.target-mode}")
                          resolve(output)
                      else
                          reject("Cant parse #{opts.target-mode}");
              else
                  resolve("```#block```")
            catch e
                debug "Error: #e"
                resolve("```Error processing exemd: #e```")

    opts.plugin-template = plugin-template

    debug "Invoking process"
    debug opts

    process(block, opts).then (-> done(null, (it))), (-> done(it, null))


    # console.log p3




code-block = v().then("```")
                .anythingBut("```")
                .then("```")


code-regex = code-block



match-array = []
promise-array = []

par = (regex, replace-handler, string) -->
    let lstring = string
        new Promise (res, rej) ->
            asyncrepl lstring, regex, replace-handler, (err, result) ->
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

promised-replace = (regex, replace-handler, string) ->
    promiseWhile string, par(regex, replace-handler)


_module = ->




    process = (target-mode, text) ->

        [ final-src, dia-mode ] = $.words(target-mode, ',')

        dia-mode    ?= 'default'
        final-src   ?= 'html'

        tmpdir = prepare!

        # debug JSON.stringify(code-regex, 0, 4)
        # debug JSON.stringify(header, 0, 4)
        # debug JSON.stringify(block, 0, 4)

        convert = ->
            if final-src == 'raw'
                rm('-rf', tmpdir)
                return it
            else
                if final-src == 'html'
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
                    throw "unsupported #final-src"


        promised-replace(code-regex, replace-handler-gen(tmpdir, dia-mode), text)
        .then convert, ->
            rm('-rf', tmpdir)
            throw it

    iface = {
        process: process
    }


module.exports = _module()
