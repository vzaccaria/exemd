
all: index.js command.js 
	cd ../exemd-dot && make
	DEBUG=* exemd -p ./test/test4/source.md

command.js: command.ls
	echo '#!/usr/bin/env node' > $@
	lsc -p -c $<  >> $@
	chmod +x $@


index.js: index.ls
	lsc -p -c $<  > $@

readme.md: ./docs/readme.md ./docs/tool-usage.md ./package.json
	verb

tst: 
	./test/test.sh


clean:
	rm index.js
	rm -rf ./figures

XYZ = node_modules/.bin/xyz

.PHONY: release-major release-minor release-patch
        
release-major release-minor release-patch:
        @$(XYZ) --increment $(@:release-%=%)