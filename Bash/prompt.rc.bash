#!/bin/bash

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
if shell_is_interactive
then
    PS1="\[\e[G\][\h:\w\$(__git_ps1 \" (%s)\")] \[\e[1;34m\]\u\[\e[0m\]\`[ \$? -ne 0 ] && echo -n '\[\e[00;31m\]'\`\\$\[\e[0m\] "
fi
        # My prompt line: 	"[hostname:~/Documents] <span style="font-color:blue;font-weight:bold;">user</span>$ " ('#' instead of '$', if root) ('$' becomes <span style="font-color:red;">$</span> when previous command failed)
        # Current git branch will appear after current directory, if appropriate.
        # Prompt will _always_ start at the beginning of the line.
##
