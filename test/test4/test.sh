#!/usr/bin/env sh
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`

bindir=$srcdir/../..
npm=$srcdir/../../node_modules/.bin

cd $srcdir && $bindir/cli.js -p $srcdir/source.md > $srcdir/dest.md
$npm/diff-files $srcdir/dest.md $srcdir/ref.md -m "Test pdf md 2."
