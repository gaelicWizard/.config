#!/bin/bash --fail

declare auto_resume=exact           # I'll prolly never use this.
shopt -so nounset                   # Error on unset parameters.
shopt -s no_empty_cmd_completion    # Don't expand all available commands.
shopt -s checkhash                  # Check that hash is usable before using it
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
HISTCONTROL="ignoredups:erasedups:ignorespace"
    # Drop repeats (redundant) from recorded history, 
    # exclude repeats from loaded history, and
    # drop lines beginning with a space.
HISTFILE="${XDG_STATE_HOME:-~/.local/state}/bash/history"
#HISTTIMEFORMAT= # man strftime

CDPATH=":~:/Volumes:~/Projects"
    # An empty first element means current-directory, but doesn't print every single time used.

function _history_merge_f ()
{
    history -a
        # Append new history immediately.
    history -c
        # Clear in-memory history.
    history -r
        # Re-read history from disk.
}

declare -F prompt_command_append >/dev/null || { echo "bash.rc.bash: Unable to manipulate prompt." 1>&2; return; }
    # Import my prompt_commands package, required by prompt_command_append()

prompt_command_append "_history_merge_f"
