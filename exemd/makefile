.DEFAULT_GOAL := all

.build/0-client.css: assets/less/client.less assets/less/material.less
	lessc assets/less/client.less .build/0-client.css

_site/css/client.css: .build/0-client.css
	@mkdir -p _site/css/
	cp .build/0-client.css $@

.build/1-index.html: assets/example.html assets/index.jade
	cat assets/index.jade  | jade -O ./site.json -P -p assets/index.jade | beml-cli  | stupid-replace {{include}} -f ./assets/example.html | stupid-replace {{usage}} -f ./assets/usage.html > .build/1-index.html 

_site/index.html: .build/1-index.html
	@mkdir -p _site/
	cp .build/1-index.html $@

.build/2-client.js: assets/js/client.ls
	browserify -t liveify assets/js/client.ls -o .build/2-client.js

_site/js/client.js: .build/2-client.js
	@mkdir -p _site//js
	cp .build/2-client.js $@

.build/3-example.md: assets/example.md
	cp assets/example.md .build/3-example.md

_site/example.md: .build/3-example.md
	@mkdir -p _site/
	cp .build/3-example.md $@

.PHONY : all
all: _site/css/client.css _site/index.html _site/js/client.js _site/example.md

.PHONY : cmd-4
cmd-4: 
	make all

.PHONY : cmd-5
cmd-5: 
	blog-ftp-cli -l _site -r /exemd

.PHONY : cmd-seq-6
cmd-seq-6: 
	make cmd-4
	make cmd-5

.PHONY : deploy
deploy: cmd-seq-6

.PHONY : cmd-7
cmd-7: 
	../cli.js -g ./assets/example.md > ./assets/example.html

.PHONY : cmd-8
cmd-8: 
	cat ../docs/usage.md ../docs/description.md | pandoc > ./assets/usage.html

.PHONY : update-docs
update-docs: cmd-7 cmd-8

.PHONY : cmd-9
cmd-9: 
	make update-docs

.PHONY : cmd-10
cmd-10: 
	make all

.PHONY : cmd-seq-11
cmd-seq-11: 
	make cmd-9
	make cmd-10

.PHONY : complete
complete: cmd-seq-11

.PHONY : clean-12
clean-12: 
	rm -rf .build/0-client.css _site/css/client.css .build/1-index.html _site/index.html .build/2-client.js _site/js/client.js .build/3-example.md _site/example.md

.PHONY : clean-13
clean-13: 
	rm -rf .build

.PHONY : clean-14
clean-14: 
	mkdir -p .build

.PHONY : cmd-15
cmd-15: 
	rm -rf _site

.PHONY : clean
clean: clean-12 clean-13 clean-14 cmd-15
