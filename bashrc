#!/bin/bash -c 'echo This file is meant to be sourced.'

if [ -n "$BASH_ENV" ] #&& [ -r "$BASH_ENV" ]
# slight variation on what bash(1) reports as $BASH_ENV's equivelant.
then
    eval source \"${BASH_ENV}\"
    # I believe this will properly expand the _contents_ of BASH_ENV
fi

import trash
    # Import my trash package
import aqua
    # Import my aqua package
import path
    # Import my path package
import editor
    # Import my editor package
import screen
    # Import my screen package
import ssh
    # Import my ssh package
import compiler
    # Import my compiler package
import you_complete_me
    # Import my completion package
import general
    # Import my general package
import history
    # Import my history package
import macports
    # Import my macports package
import rip
    # Import my rip package
import rcstools
    # Import my rcstools package

#import bash_completion
    # Import the widely used, huge, can do everything, Bash Completion package

return 0
    # I deliberately return from this script early, since I occasionally fail to properly audit installers which bjork my system (i.e. MacPorts).
