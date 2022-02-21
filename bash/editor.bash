#!/bin/bash --fail

: "${VISUAL:=mate_wait}"
: "${EDITOR:=emacsclient}"
: "${ALTERNATE_EDITOR:=nano}"

#: "${EDITOR:=~/Tools/mate_wait}" "${ALTERNATE_EDITOR:=/usr/bin/nano}"

alias e='${VISUAL:-${EDITOR:-${ALTERNATE_EDITOR:-pico}}}' # simpler, shorter, better.
	# If we're in a situation where everything is missing, then `pico` is slightly more likely to be installed.
