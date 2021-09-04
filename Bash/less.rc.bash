#!/bin/bash

if type -p lesspipe.sh >/dev/null
then
	export LESSOPEN="|lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi

if type -p less >/dev/null
then
	export LESS='Ris'
	# Show color, match patterns case-insensitively, and deduplicate consequtive blank lines.
fi
