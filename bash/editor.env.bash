#!/bin/bash --fail

: "${EDITOR:=~/Tools/mate_wait}" "${ALTERNATE_EDITOR:=/usr/bin/nano}"

alias e='${EDITOR:-nano}' # simpler, shorter, better.
