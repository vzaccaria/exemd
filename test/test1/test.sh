#!/usr/bin/env sh
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`

bindir=$srcdir/../..
npm=$srcdir/../../node_modules/.bin

$bindir/cli.js -g $srcdir/source.md > $srcdir/dest.html 
$npm/diff-files $srcdir/dest.html $srcdir/ref.html -m "Test html 2."
