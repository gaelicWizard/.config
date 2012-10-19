#!/bin/bash --fail

EDITOR="mate -w"

if [ -z "${EDITOR:-}" ]
then
    if [ -e "${HOME}/Tools/seewr.sh" ]
    then
        export EDITOR="${HOME}/Tools/seewr.sh"
        # This allows me to use SubEthaEdit as my editor :-D
    elif [ -e "${HOME}/Tools/emacs.sh" ]
    then
        export EDITOR="${HOME}/Tools/emacs.sh"
        # This script allows me to control emacs through screen.
    else
        export EDITOR="nano"
    fi
fi


# File editing
#alias e='${EDITOR:-nano}' # simpler, shorter, better.
