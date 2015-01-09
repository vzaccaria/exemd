#!/usr/bin/env sh 
set -e

#!/usr/bin/env sh 
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`


for f in $srcdir/test*
do
  # is it a directory?
  if [ -d "$f" ]; then
      rm -f $f/dest*
  fi
done
