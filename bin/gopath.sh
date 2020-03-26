#!/bin/sh

if [ -n "$1" ]; then
    BASE="$1"
else
    # Try to deduce the GOPATH as the root-most dir in the current path
    BASE="/$(pwd -P | cut -d "/" -f2)"
fi


if [ ! -d $BASE/bin -o ! -d $BASE/src -o ! -d $BASE/pkg ]; then
  echo "$BASE doesn't look like a go path!"
else
  # remove $GOPATH/bin if it's there
  if [ -n "$GOPATH" ]; then
      PATH=$(echo "$PATH" | sed "s#:$GOPATH/bin##g")
      PATH=$(echo "$PATH" | sed "s#:$GOPATH/src/github.com/cockroachdb/cockroach/bin##g")
  fi

  echo "Setting GOPATH to $BASE"
  export GOPATH=$BASE
  export PATH=$PATH:$GOPATH/bin:$GOPATH/src/github.com/cockroachdb/cockroach/bin
  echo "Path updated to $PATH"
fi
