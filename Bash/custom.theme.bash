#!/bin/bash --interactive

##
if shell_is_interactive
then
    PS1="\[\e[G\][\h:\w\$(oy=$?; __git_ps1 \" (%s)\" 2>/dev/null; exit \$oy)] \[\e[1;34m\]\u\[\e[0m\]\`[ \$? -ne 0 ] && echo -n '\[\e[00;31m\]'\`\\$\[\e[0m\] "
fi
        # My prompt line: 	"[hostname:~/Documents] <span style="font-color:blue;font-weight:bold;">user</span>$ " ('#' instead of '$', if root) ('$' becomes <span style="font-color:red;">$</span> when previous command failed)
        # Current git branch will appear after current directory, if appropriate.
        # Prompt will _always_ start at the beginning of the line.
##
