#!/bin/bash --fail

declare auto_resume=exact           # I'll prolly never use this.
shopt -so nounset                   # Error on unset parameters.
shopt -s no_empty_cmd_completion    # Don't expand all available commands.
#shopt -s failglob                   # Don't continue if a pattern doesn't match any filenames.
#shopt -s nullglob                   # Don't pass the pattern itself when expanding filenames.
shopt -s nocaseglob                 # Case-insensitive filename expansion.
shopt -s shift_verbose              # Minor debugging info.
shopt -s sourcepath                 # Don't search $PATH for the source builtin.
shopt -s xpg_echo                   # Interpret escape sequences in echo builtin.
#suspend                             # SIGSTOP stops the shell itself.
#huponexit
shopt -so pipefail                 # Return the error on a failed pipe.
shopt -s cdspell                    # Spell check cd(builtin)
shopt -s checkwinsize               # Update $LINES/$COLUMNS when sigwinch
#shopt -s dotglob                    # Include hidden files in expansion (not completion).
#shopt -s extdebug                   # Allows DEBUG RETURN ERROR trap inheritance. (See bash(1).)

shopt -s cmdhist                    # save multi-line commands as one long entry (bug: comments)
shopt -s histappend                 # append to history file instead of overwriting
shopt -s histverify                 #  allow editing of commands retreived from history,
HISTSIZE=10000 # 10k
    # Keep a _much_ longer history. (default == 500)
HISTFILESIZE=100000 # 100k
    # Don't truncate the history file until it is ENORMOUS.
HISTIGNORE="&:l:ls:ls -la:ls -lA:cd:[bf]g:exit:quit:bye"
    # Drop repeats and other useless things from the command history.
HISTCONTROL="ignoredups:ignorespace"
    # Drop repeats (redundant), and drop lines beginning with a space.

CDPATH=":~:/Volumes"
    # An empty first element means current-directory, but doesn't print every single time used.


declare -F prompt_command_append >/dev/null || { echo "bash.rc.bash: Unable to manipulate prompt." 1>&2; return; }
    # Import my prompt_commands package, required by prompt_command_append()

prompt_command_append "history -a"
    # append the command history right away
#prompt_command_append "history -n"
    # read in any new entries right away
    # this is resource intensive, requiring disk access after each command...
    # this also has the effect of doubling all of the recent history... so disabled...

