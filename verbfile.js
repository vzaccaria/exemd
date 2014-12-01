var verb = require('verb');

// load data to pass to templates.
verb.data('package.json');

verb.partials('docs/*.md');

verb.task('default', function() {
  verb.src(['docs/readme.md'])
    .pipe(verb.dest('./'));
});
