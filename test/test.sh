#!/usr/bin/env sh 
set -e

#!/usr/bin/env sh 
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`

$srcdir/cleanup.sh

for f in $srcdir/test*
do
  # is it a directory?
  if [ -d "$f" ]; then
      $f/test.sh
  fi
done
