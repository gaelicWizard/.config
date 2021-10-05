#!/bin/bash --interactive

##
if shell_is_interactive
then #\$(oy=$?; __git_ps1 \" (%s)\" 2>/dev/null; exit \$oy)
	PS1="\[\e[G\][\[${echo_yellow:-}\]\h\[${echo_normal:-}\]:\w] \[${echo_blue:-}\]\u\[${echo_normal:-}\]\[\`[ \$? -ne 0 ] && echo -n '${echo_red:-}'\`\]\\$\[${echo_normal:-}\] "
fi
# My prompt line: 	"[hostname:~/Documents] <span style="font-color:blue;font-weight:bold;">user</span>$ " ('#' instead of '$', if root) ('$' becomes <span style="font-color:red;">$</span> when previous command failed)
# Prompt will _always_ start at the beginning of the line.
##
