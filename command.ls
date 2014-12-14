
{docopt}             = require('docopt')
_                    = require('lodash')
{cat,mkdir,rm, exec} = require('shelljs')
v                    = require('verbal-expressions')
uid                  = require('uid')
Promise              = require('bluebird')
asyncrepl            = require('async-replace')
{process} = require('./index')

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


text = cat(FILE)

process(target-mode, text).then ->
    console.log it







