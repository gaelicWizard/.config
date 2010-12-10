#!/bin/bash --rcfile "$0" --fail

declare auto_resume=exact # I'll prolly never use this.
shopt -s nounset # Error on unset parameters.
shopt -s no_empty_cmd_completion # Don't expand all available commands.
#shopt -s failglob # Fail if a pattern doesn't match any filenames.
#shopt -s nullglob # Don't pass the pattern itself when expanding filenames.
shopt -s nocaseglob # Case-insensitive filename expansion.
shopt -s shift_verbose # Minor debugging info.
shopt -s sourcepath # Don't search $PATH for the source builtin.
shopt -s xpg_echo # Interpret escape sequences in echo builtin.
#suspend # SIGSTOP the shell itself.
#shopt -s pipefail # Return the error on a failed pipe.
