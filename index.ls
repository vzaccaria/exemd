
{docopt}       = require('docopt')
_              = require('lodash')
{cat,mkdir,rm} = require('shelljs')
v              = require('verbal-expressions')
uid            = require('uid')
Promise        = require('bluebird')
asyncrepl      = require('async-replace')

module-path = "/usr/local/share/npm/lib/node_modules/"

require! 'fs'

doc = """
Usage:
    exemd FILE [ -p | --pdf ] [ -r | --pure ] 
    exemd -h | --help 

Options:
    -p, --pdf   Generate a pdf
    -r, --raw   Unfold and execute blocks, generate raw markdown
    -h, --help  

Arguments: 
    FILE       markdown file name.

"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else
        return o[b]

o = docopt(doc)

FILE = o['FILE']

f = cat(FILE)

src = __dirname
cwd = process.cwd()

prepare = ->
    dirname = "#cwd/tmp#{uid(7)}"
    mkdir(dirname)
    return dirname


replace-code = (tmpdir, m, lang, params, code, offset, string, done) -->

    {process} = require("#{module-path}exemd-#{lang}")
    opts = {}
    opts.target-mode = 'html'
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

tmpdir = prepare!

match-array = []
promise-array = []

promised-replace = (regex, my-async-replace, string) -->
    new Promise (res, rej) ->
        asyncrepl string, regex, my-async-replace, (err, result) ->
            if err
                rej(err)
            else
                res(result)

promised-replace(code-regex, replace-code(tmpdir), f)
    .then ->
        console.log it
    .done ->
        console.log "done!"
        rm('-rf', tmpdir)


# while (match-array = code-regex.exec(f)) != null
#     m = match-array
#     promise-array.push(replace-code(m[0], m[1], m[2], m[3], tmpdir))

# bb.all(promise-array).then ->





