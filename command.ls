
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
    exemd FILE [ -r | --raw ] [ -g | --force-png ]
    exemd -h | --help 

Options:
    -g, --force-png     Force png generation
    -r, --raw           Unfold and execute blocks, generate raw markdown
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

if o['-g'] or o['--force-png'] 
    target-mode = 'html,png'
else
    if o['--raw'] or o['-r']
        target-mode = 'raw,png'
    else 
        target-mode = 'html'

FILE = o['FILE']


text = cat(FILE)

process(target-mode, text).then ->
    console.log it







