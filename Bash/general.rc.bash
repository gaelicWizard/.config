#!/bin/sh -c 'echo This file is meant to be sourced.'

export BLOCKSIZE=1024 # make tools report in 1m increments, not 512k... $POSIX_ME_HARDER

mkdir -p -m u+rwX,go-rwx "${SHELL_SESSION_DIR:=${XDG_STATE_HOME:-$HOME/.}${XDG_STATE_HOME:+/}bash_sessions}"
readonly SHELL_SESSION_DIR

if [ -r "/etc/bashrc_${TERM_PROGRAM:-}" ]
then
    : "${INSIDE_EMACS:=}"
	_bash_it_log_section=${TERM_PROGRAM:-TERM_PROGRAM}
    source /etc/bashrc_${TERM_PROGRAM:-} 2> >(fgrep -v "PROMPT_COMMAND: readonly" | fgrep -v "SHELL_SESSION_DIR: readonly")
        # Import Apple's weird session management stuff...just for some functions
        # Agressively discard the attempt to alter $PROMPT_COMMAND
        # Agressively discard the attempt to alter $SHELL_SESSION_DIR
    [ -z "$INSIDE_EMACS" ] && unset INSIDE_EMACS
        # Deal with Apple's shody code standards
    safe_append_prompt_command '_screen_print_dcs_f `update_terminal_cwd`' || { echo "general.rc.bash: Unable to manipulate prompt." 1>&2; return; }
    #shell_session_save_user_state() { echo MY_VAR="'$MY_VAR'" >> "$SHELL_SESSION_FILE"; }
fi

#alias locate='locate.sh'
alias gam="python ~/Projects/External/GoogleAppsManager.svn/gam.py"

## Generally useful functions :-)
function ls ()
{ command ls -AFOh "$@" ; } 
    # 'command ls' to prevent loop; -A for .file, -G for color (see $CLICOLOR), -F for dir/ link@, -h for 5k 3m 1g, -O for uchg...
function l ()
{ ls -l "$@"; } 
    # -l to list in long format...
function ll ()
{ CLICOLOR_FORCE="${CLICOLOR:-}" l "$@" | less -e -R ; } 
    # pipe into 'less', tell less to honor colors and to exit at end

alias locate="locate -i" # case insensitive
function locate ()
{
	local -i HOURS=$(( 60*60 )) # sixty minutes of sixty seconds.
    local -i MAXAGE=$(( 24 * $HOURS )) # twenty-four hours.
    local -i NOW="$(date +%s)" # seconds since EPOCH.
    local DB="/var/db/locate.database"

    if [ ! -e "$DB" ]
    then
        echo "$FUNCNAME: $DB does not exist. Initializing..." > /dev/stderr
        sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/stderr
        echo "$FUNCNAME: Please try again in a few minutes." > /dev/stderr
        return -1 # stop and fail, there's nothing we can do until the database has been created.
    fi

    local DBCREATED="$(eval $(stat -s $DB); echo $st_mtime )"
    local DBAGE="$(( $NOW - $MAXAGE ))"

    if [ $DBAGE -gt $NOW ]
    then
        echo "$FUNCNAME: $DB is more than $(( $MAXAGE / $HOURS )) hours old. Updating..." > /dev/stderr
        sudo launchctl start com.apple.locate > /dev/stderr
        echo "$FUNCNAME: stale results: " > /dev/stderr
    fi

    command locate "$@"
}

function lleaks ()
{
    leaks "$@" | less
}

alias which='type -p' # 'which' in (t)csh is same(?) as 'type -p' in bash...?

# Set $COLORTERM, all this does is trick *some* apps into 
# using color in the terminal, which should happen anyway.
if [ -z "${COLORTERM:-}" ];then 
	export COLORTERM="${TERM}" 
	   # I don't know what COLORTERM should actually be set to
fi

# Be careful there...
alias cp='cp -i' # Don't overwrite w/o my permission!
alias mv='mv -i' # Ditto...
 
alias swap="vm_stat && ls -l /System/Volumes/VM/swapfile* | awk '{print \$6 \" \"  \$10}'"
    # How many swap files again?
alias swaploop="while clear; do swap; sleep 10; done"

alias flushcache="dscacheutil -flushcache"

function seq () { jot - "$@" ; }

function randomint ()
{
    dd if=/dev/random count=1 2>/dev/null | od -t u1 | awk 'NR==1 {print $2$4}'
}

function randomword ()
{
    sed "$(randomint)""q;d" /usr/share/dict/words
}

function chext ()
{ 
    local FILE
    if [ "$#" -lt 3 ]
    then
        rtrn 1
    fi
    # TODO: input validation...
    for FILE in *."$1"
    do 
        mv -v "$FILE" "`echo $FILE | sed 's/\(.*\.\)'$1'/\1'$2'/'`" 
    done
}

# Some aliases to fix line-endings. 
alias LF="perl -pi -e 's/\r\n/\n/g;s/\r/\n/g' "
alias CR="perl -pi -e 's/\r\n/\n/g;s/\n/\r/g' "
alias CRLF="perl -pi -e 's/\r\n/\n/g;s/\r/\n/g;s/\n/\r\n/g' "

alias chmac=CR # Make all line endings all mac
alias chunx=LF # Make all line endings all unix
alias chdos=CRLF # Make all line endings all windoze

alias iforgot='sudo strings /var/vm/swapfile? |grep -A 4 -i longname ;echo'
    # This searches my swap files for my password



# The rest are uncategorised and fairly random... :-)
alias ztpm='ps axm -o pid,stat,rss,time,command | head -20' 
    # Ummm....? I don't know what this does, actually...
alias note='cat >> "`date "+%a %b %e %Y"`.txt"'
alias screen_aevt='screen env AEDebugReceives=1 AEDebugSends=1'
alias nyan='screen -t nyan nc miku.acm.uiuc.edu 23'

#set -o noclobber

function pidof () { ps -Ac | awk '/'"$*"'/ {print $1}'; }

function ass ()
{
    if [ "$1" ] && declare -F isscreen >/dev/null && isscreen
    then
        screen -t "$(basename $1)" 20 tail -F "$@"
    else
        tail -F "$@"
    fi
}

function google ()
{
    open 'http://www.google.com/search?client=safari&q='"$*"
}

function nproc()
{
	sysctl -n hw.ncpu
}
