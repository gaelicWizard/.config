#!/bin/bash

function isinteractive () 
{ [[ "$-" = *i* ]]; }
    # Check if the current shell was invoked interactively

function localisePath ()
{
    return -1
    # This function should take a single argument, the path to a folder. It should then traverse that path replacing each path component with its corresponding localised version, as extracted from a '.localized' folder.
}

function colouriseText ()
{
    return -1
    # This function should take two arguments: (1) a colour suitible for use in an ANSI escape sequence and (2) a string to be `echo`d in that colour.
    # It should then issue the appropriate terminal escape sequence, then the string, then the appropriate reset code. 
}

##
if isinteractive
then
    PS1="[\h:\w\$(__git_ps1 \" (%s)\")] \[\e[1;34m\]\u\[\e[0m\]\`[ \$? -ne 0 ] && echo -n '\[\e[00;31m\]'\`\\$\`echo -n '\[\e[0m\]'\` "
    bind '"\e[A"':history-search-backward
    	# Bind the up arrow to history search, instead of history step...
    bind '"\e[B"':history-search-forward
	   # Ditto for down, type "x" [up] and it will look for the last x??? command
fi
        # My prompt line: 	"[hostname:~/Documents] <span style="font-color:blue;font-weight:bold;">user</span>$ " ('#' instead of '$', if root) ('$' becomes <span style="font-color:red;">$</span> when previous command failed)
        # Current git branch will appear after current directory, if appropriate.
##
