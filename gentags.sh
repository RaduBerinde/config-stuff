#!/bin/sh

set -e
cd /go/src/github.com/cockroachdb
/go/bin/gotags -R . > tags 2>/root/gentags.log

if [ -d /go2 ]; then
    cd /go2/src/github.com/cockroachdb
    /go/bin/gotags -R . > tags 2>>/root/gentags.log
fi
