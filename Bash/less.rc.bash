#!/bin/bash

if type -p lesspipe.sh >/dev/null
then
	export LESSOPEN="|lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi
