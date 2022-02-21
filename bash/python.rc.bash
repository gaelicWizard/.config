#!/bin/bash --fail

pathmunge "/Library/Python/bin"

alias easy_uninstall="easy_install -mxN"
    # -m: multi-version, i.e. remove from easy-install.pth
    # -x: exclude scripts, i.e. remove them
    # -N: don't install dependencies
    # NOTE: This will not actually remove the egg.

type -p pip >/dev/null && false &&
    eval "`pip completion --bash 2>/dev/null`"
