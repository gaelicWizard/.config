#!/bin/bash --rcfile "$0" --fail

declare auto_resume=exact # I'll prolly never use this.
shopt -so nounset # Error on unset parameters.
shopt -s no_empty_cmd_completion # Don't expand all available commands.
#shopt -s failglob # Fail if a pattern doesn't match any filenames.
#shopt -s nullglob # Don't pass the pattern itself when expanding filenames.
shopt -s nocaseglob # Case-insensitive filename expansion.
shopt -s shift_verbose # Minor debugging info.
shopt -s sourcepath # Don't search $PATH for the source builtin.
shopt -s xpg_echo # Interpret escape sequences in echo builtin.
#suspend # SIGSTOP the shell itself.
#shopt -s pipefail # Return the error on a failed pipe.
#!/bin/sh -c 'echo "Your father smelt of eldarberries!"'

shopt -s cmdhist histappend histverify
    # save multi-line commands as one entry, append to history instead of overwriting,
    #  allow editing of commands retreived from history,
HISTSIZE=10000
    # Keep a much longer history. (default == 500)
HISTIGNORE="&:l:ls:cd:[bf]g:exit:quit:bye"
    # This kicks-ass! It drops repeats and other useless 
    # things from the command history! 


require prompt_commands.bashrc || return -1
    # Import my prompt_commands package, required by prompt_command_append()

prompt_command_append "history -a"
    # appent the command history right away
#prompt_command_append "history -n"
    # read in any new entries right away
    # this is resource intensive, requiring disk access after each command...
    # this also has the effect of doubling all of the recent history... so disabled...
