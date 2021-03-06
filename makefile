# Makefile autogenerated by Dyi on March 18, 2015
#
# Main target: all
# Sources:  command.ls  index.ls 

.DEFAULT_GOAL := all


.PHONY: c-fv0najgh
c-fv0najgh: command.js index.js


.PHONY: build
build: c-fv0najgh


.PHONY: docs
docs: k-9sur3gj0


.PHONY: test
test: k-8xeqbjkg


.PHONY: up
up: k-xn1vlpc0


.PHONY: major
major: k-2r6e0yeo k-n8p9qckv k-pcfnudjh


.PHONY: minor
minor: k-tnanvr1m k-eofngwwt k-7n07wlr6


.PHONY: patch
patch: k-9b27l9lk k-r7sruard k-36s4066q


.PHONY: prepare
prepare: .




.PHONY: k-w5665s2t
k-w5665s2t:  
	((echo '#!/usr/bin/env node') && cat command.js) > cli.js


.PHONY: k-o5rxyt3h
k-o5rxyt3h:  
	chmod +x ./cli.js


.PHONY: all
all: 
	make build 
	make k-w5665s2t 
	make k-o5rxyt3h  


.PHONY: k-9sur3gj0
k-9sur3gj0:  
	./node_modules/.bin/verb


.PHONY: k-8xeqbjkg
k-8xeqbjkg:  
	./test/test.sh


.PHONY: k-xn1vlpc0
k-xn1vlpc0:  
	make clean && ./node_modules/.bin/babel configure.js | node


.PHONY: k-2r6e0yeo
k-2r6e0yeo:  
	make all


.PHONY: k-n8p9qckv
k-n8p9qckv:  
	make docs


.PHONY: k-pcfnudjh
k-pcfnudjh:  
	./node_modules/.bin/xyz -i major


.PHONY: k-tnanvr1m
k-tnanvr1m:  
	make all


.PHONY: k-eofngwwt
k-eofngwwt:  
	make docs


.PHONY: k-7n07wlr6
k-7n07wlr6:  
	./node_modules/.bin/xyz -i minor


.PHONY: k-9b27l9lk
k-9b27l9lk:  
	make all


.PHONY: k-r7sruard
k-r7sruard:  
	make docs


.PHONY: k-36s4066q
k-36s4066q:  
	./node_modules/.bin/xyz -i patch


.PHONY: clean
clean:  
	rm -f command.js
	rm -f index.js


.PHONY: update
update: 
	make clean   
	node




command.js: command.ls 
	lsc -c command.ls

index.js: index.ls 
	lsc -c index.ls

.: 
	mkdir -p .

