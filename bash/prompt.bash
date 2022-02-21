# shellcheck shell=bash

##
if shell_is_interactive
then #\$(oy=$?; __git_ps1 \" (%s)\" 2>/dev/null; exit \$oy)
	PS0="${normal:-}\[\e]7;file://\h/\${PWD}\a\]"
	PROMPT="\[\e[G\]${normal:-}[${yellow:-}\h${normal:-}:\w v\v] ${blue:-}\u${normal:-}\`[[ \$? -ne 0 ]] && printf '${red:-}'\`\\\$${normal:-} "
fi
# My prompt line: 	"[hostname:~/Documents] <span style="font-color:blue;font-weight:bold;">user</span>$ " ('#' instead of '$', if root) ('$' becomes <span style="font-color:red;">$</span> when previous command failed)
# Prompt will _always_ start at the beginning of the line.
##
