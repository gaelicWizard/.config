#!/bin/bash --fail

: ${VISUAL:=mate_wait}
: ${EDITOR:=emacsclient}
: ${ALTERNATE_EDITOR:=nano}

#: "${EDITOR:=~/Tools/mate_wait}" "${ALTERNATE_EDITOR:=/usr/bin/nano}"

alias e='${EDITOR:-nano}' # simpler, shorter, better.
