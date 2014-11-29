var verb = require('verb');

// load data to pass to templates.
verb.data('package.json');

verb.task('default', function() {
  verb.src(['docs/*.md'])
    .pipe(verb.dest('./'));
});
