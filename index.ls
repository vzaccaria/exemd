
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

doc = """
Usage:
    exemd FILE [ -p | --pdf ] [ -r | --raw ] 
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

if o['--pdf'] or o['-p'] 
    target-mode = 'pdf'
else
    if o['--raw'] or o['-r']
        target-mode = 'raw'
    else 
        target-mode = 'html'

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

tmpdir = prepare!

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

promised-replace(code-regex, replace-code(tmpdir), f)
    .then ->
        if target-mode == 'raw'
            console.log it
        else
            if target-mode == 'html' 
                tmp-markdown = "#{tmpdir}/#{uid(7)}.md"
                it.to(tmp-markdown)
                exec("pandoc -s #tmp-markdown")

    .done ->
        rm('-rf', tmpdir)


# while (match-array = code-regex.exec(f)) != null
#     m = match-array
#     promise-array.push(replace-code(m[0], m[1], m[2], m[3], tmpdir))

# bb.all(promise-array).then ->





