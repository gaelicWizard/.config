#!/bin/bash --fail

# if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi

source ~/.bashrc.d/bashd
    # backwards-compatability

function bashrcD ()
{
    local bashrc
    for bashrc in ~/.bashrc.d/*.bashrc
    do
        echo "$bashrc"
        source "$bashrc"
    done
}

bashrcD
return
    # I deliberately return from this script early, since I occasionally fail to properly audit installers which bjork my system (i.e. MacPorts, which appends to .bashrc).
