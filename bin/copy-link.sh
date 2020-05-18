#!/bin/bash

echo "$*" | xclip -i
xmessage -timeout 2 "$* copied to clipboard"
