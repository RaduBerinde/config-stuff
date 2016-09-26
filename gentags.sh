#!/bin/sh

GOSRC_DIRS=/go*/src
REL_PATHS="github.com/cockroachdb golang.org/x github.com/opentracing github.com/lightstep"
LOGFILE=~/gentags.log

set -e

echo "REL_PATHS: $REL_PATHS" > $LOGFILE
for gosrc in $GOSRC_DIRS; do
  # Leave a tags file in each directory.
  for path in $REL_PATHS; do
    cd $gosrc/$path
    echo "Running in `pwd -P`" >> $LOGFILE
    /go/bin/gotags -R . > tags 2>>$LOGFILE
  done

  # Also leave a "root" tags file. This file is consulted if an identifier is
  # not found in a tags file inside a more specific subdir.
  cd $gosrc
  echo "Running in `pwd -P`" >> $LOGFILE
  /go/bin/gotags -R $REL_PATHS > tags 2>>$LOGFILE
done
