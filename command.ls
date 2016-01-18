
{docopt}             = require('docopt')
_                    = require('lodash')
shelljs = {cat,mkdir,rm, exec} = require('shelljs')
shelljs.config.silent = true;
v                    = require('verbal-expressions')
uid                  = require('uid')
Promise              = require('bluebird')
asyncrepl            = require('async-replace')
{ printAll }        = require('plugin-space')
{process} = require('./index')

#module-path = "/usr/local/share/npm/lib/node_modules/"
module-path = ""

require! 'fs'

doc = fs.readFileSync(__dirname+"/docs/usage.md", 'utf8')

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else
        return o[b]

o = docopt(doc)

if not o['list']

  if o['-g'] or o['--force-png']
      target-mode = 'html,png'
  else
      if o['--raw'] or o['-r']
          target-mode = 'raw,png'
      else
          if o['-p'] or o['--pdf']
              target-mode = 'raw,pdf'
          else
              target-mode = 'html'

  FILE = o['FILE']


  text = cat(FILE)

  process(target-mode, text).then ->
      console.log it

else
  console.log "Available plugin list:"
  console.log ""
  printAll("exemd").caught (err, resp)->
    console.log err, resp
