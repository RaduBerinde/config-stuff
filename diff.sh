#!/bin/sh

diff -qr ~/. . | grep -v "Only in /root"
