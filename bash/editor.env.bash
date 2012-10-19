#!/bin/bash --fail

: "${EDITOR:=mate_wait}" "${ALTERNATE_EDITOR:=nano}"

alias e='${EDITOR:-nano}' # simpler, shorter, better.
