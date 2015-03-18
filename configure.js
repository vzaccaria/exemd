var {
  generateProject
} = require('diy-build')

generateProject(_ => {
  _.collectSeq("all", _ => {
    _.collect("build", _ => {
      _.livescript("*.ls")

    })
    _.cmd("((echo '#!/usr/bin/env node') && cat command.js) > cli.js", "command.js")
    _.cmd("chmod +x ./cli.js", "cli.js")
  })

  _.collect("docs", _ => {
    _.cmd("./node_modules/.bin/verb", "docs/*.md")
  })

  _.collect("test", _ => {
    _.cmd("./test/test.sh")
  })

  _.collect("up", _ => {
    _.cmd("make clean && ./node_modules/.bin/babel configure.js | node")
  });

  ["major", "minor", "patch"].map(it => {
    _.collect(it, _ => {
      _.cmd(`make all`)
      _.cmd(`./node_modules/.bin/xyz -i ${it}`)
    })
  })

})
