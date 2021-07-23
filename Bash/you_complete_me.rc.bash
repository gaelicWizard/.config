#!/bin/bash --fail

##
# This file should be entirely superfluous. There is _no_ point to 90% of this. Why have it? Because bash(1) lacks any sort of intelligence: completion in bash is available but unactivated. So, this file activates it.
##

# Specify where to find a list of hostnames, like /etc/hosts
#HOSTFILE=/path/to/hosts

# Turn on extended globbing and programmable completion
shopt -s extglob progcomp

# Make sudo(1) complete just like everything else! :-D
complete -c -f command sudo man
    # A function would be useful for making sudo complete only the first argument.

# Make ssh(1) complete using hosts from known_hosts and ssh_config
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=$(sed -e 's/^  *//' -e '/^#/d' -e 's/[, ].*//' -e '/\[/d' ~/.ssh/known_hosts | sort -u;
                [ -f ~/.ssh/config ] && awk '/^host/ {print $2}' ~/.ssh/config)
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur) )
}
complete -F _complete_ssh_hosts ssh slogin

# Make directory commands see only directories
complete -d pushd cd

# bg completes with stopped jobs
complete -A stopped -P '%' bg

# other job commands
complete -j -P '%' fg jobs disown

# readonly and unset complete with shell variables
complete -v readonly unset

# set completes with set options
complete -A setopt set

# shopt completes with shopt options
complete -A shopt shopt

# helptopics
complete -A helptopic help

# unalias completes with aliases
complete -a unalias

# bind completes with readline bindings
complete -A binding bind

# type, which, and command complete on commands
complete -c command type which command

# builtin completes on builtins
complete -b builtin


for completion in "${XDG_CONFIG_HOME:=$HOME/.config}/Bash/completion"/*.bash
do
    source "$completion"
done
unset completion

