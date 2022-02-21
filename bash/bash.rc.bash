#!/bin/bash --fail

declare auto_resume=exact			# I'll prolly never use this.
shopt -so nounset					# Error on unset parameters.
shopt -s no_empty_cmd_completion	# Don't expand all available commands.
shopt -s checkhash					# Check that hash is usable before using it
#shopt -s failglob					# Don't continue if a pattern doesn't match any filenames.
#shopt -s nullglob					# Don't pass the pattern itself when expanding filenames.
#shopt -s dotglob					# Include hidden files in expansion (not completion).
#shopt -s extglob					# enable extended pattern-matching features
shopt -s nocaseglob					# Case-insensitive filename expansion.
shopt -s shift_verbose				# Minor debugging info.
shopt -s sourcepath					# Don't search $PATH for the source builtin.
shopt -s xpg_echo					# Interpret escape sequences in echo builtin.
#suspend							# SIGSTOP stops the shell itself.
#huponexit
shopt -so pipefail					# Return the error on a failed pipe.
trap '' PIPE						# Some pipes failures are not handled and end up crashing the shell...
shopt -s cdspell					# Spell check cd(builtin)
#shopt -s autocd					# change to named directory
#shopt -s cdable_vars				# if cd arg is not valid, assumes its a var defining a dir
shopt -s checkwinsize				# Update $LINES/$COLUMNS when sigwinch
#shopt -s extdebug					# Allows DEBUG RETURN ERROR trap inheritance. (See bash(1).)
shopt -s hostcomplete				# attempt hostname expansion when @ is at the beginning of a word
shopt -s cmdhist					# save multi-line commands as one long entry (bug: comments)
[[ ${BASH_VERSINFO[0]} -ge 5 || ${BASH_VERSINFO[1]} -ge 4 ]] &&
shopt -s lithist					# save multi-line commands with embedded carriage returns
shopt -s histappend					# append to history file instead of overwriting
shopt -s histverify					#  allow editing of commands retreived from history,
readonly HISTSIZE=32768				# 8^5	# Keep a _much_ longer history in memory. (default == 500)
readonly HISTFILESIZE=262144		# 8^6	# Don't truncate the history file until it is ENORMOUS. (default == 500)
HISTIGNORE="&:l:ll:ls:ls -la:ls -lA:cd:history:[bf]g:exit:quit:bye"	# Drop repeats and other useless things from the command history.
HISTCONTROL="ignoredups:ignorespace:autoshare"
	# Drop repeats (redundant) from recorded history, 
	# drop lines beginning with a space.
readonly HISTFILE="${XDG_STATE_HOME:-~/.local/state}/Bash/history"

HISTTIMEFORMATFORMAT=(	# eight args: Year, Month, Day, 'T', Hour, Minute, Second, 'Z'.
	"${echo_red:-}"
	"${echo_purple:-}"
	"${echo_yellow:-}"
	"${echo_bold_white:-}"
	"${echo_blue:-}"
	"${echo_green:-}"
	"${echo_cyan:-}"
	"${echo_bold_black:-}"
	"${echo_normal:-}"
)	# "${echo_}" "${echo_}" "${echo_}" "${echo_}" "${echo_}" "${echo_}" "${echo_}" "${echo_}" "${echo_normal}"
printf -v HISTTIMEFORMAT "%b%%Y%b%%m%b%%d%bT%b%%H%b%%M%b%%S%bZ%b: " "${HISTTIMEFORMATFORMAT[@]:0:8}" "${echo_normal:-}"

CDPATH=":~" #":/Volumes:~/Projects"
	# An empty first element means current-directory, but doesn't print every single time used.

#declare autosave=1
#safe_append_prompt_command "_save-and-reload-history" || { echo "bash.rc.bash: Unable to manipulate prompt." 1>&2; return; }
