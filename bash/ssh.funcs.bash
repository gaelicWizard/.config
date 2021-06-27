#!/bin/bash --fail

function slogin () 
{
    # slogin() is meant to start a new login shell on a remote host,
    #  so it will run the slogin command (ssh) and run screen on the
    #  remote host. If we're running within screen(1), then open a
    #  new window.
    
    local i TITLE 
    
    if declare -F isscreen >/dev/null && isscreen
    then
        # The last word on the command line is the host name,
        #  since this slogin() function does run a remote command
        #  and the remote command follows the host name immediately.
        for i in "$@"
        do
            # $# == argc
            TITLE="$i"
            # This is a hack to get the last word on the command line
            #TODO:FIXME: Just get the last word. 
        done
        screen -t "$TITLE" slogin -t "$@" exec '"${SHELL:-/bin/bash}"' --login -c '"exec screen -U -xRR"'
    else
        command slogin -t "$@" exec '"${SHELL:-/bin/bash}"' --login -c '"exec screen -U -xRR"'
    fi
        # Note that both the entire ${SHELL… expression and the screen(1) expression are single-quoted, so that the local shell does not evaluate them.
        # This should run (1) if screen is available, a new screen window entitled with the hostname; (2) ssh, told to allocate a tty; (3) _exec_ the shell with --login, so as to ensure that screen(1) is run within a proper login shell, and so as to avoid a heirarchy of useless ${SHELL}s; (4) _exec_ screen told to re-attach, violently if necessary, but with minimal violence, again so as to avoid a heirarchy of useless ${SHELL}s.
}
