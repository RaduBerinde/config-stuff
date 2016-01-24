#!/bin/sh

if [ -n "$1" ]; then
    BASE="$1"
else
    # Try to deduce the GOPATH as the root-most dir in the current path
    BASE="/$(pwd -P | cut -d "/" -f2)"
fi


if [ ! -d $BASE/bin -o ! -d $BASE/src -o ! -d $BASE/pkg ]; then
    echo "$BASE doesn't look like a go path!"
    exit 1
fi

# remove $GOPATH/BIN if it's there
PATH=$(echo "$PATH" | sed "s#:$GOPATH/bin##g")

echo "Setting GOPATH to $BASE"
export GOPATH=$BASE
export PATH=$PATH:$GOPATH/bin
echo "Path updated to $PATH"
