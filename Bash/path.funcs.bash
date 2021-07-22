#!/bin/bash --fail

# These functions are meant to keep the path relatively clean.

function bashd_add_to_path_front ()
# Useful for adding ~/Tools &c.
# Basically, stuff that is intended to override other tools (or which should do so, in the event of a duplicate).
{
    local new_path_entry
    new_path_entry="$1"
    
    if [ -n "$new_path_entry" -a -d "$new_path_entry" ]
    then
        case $PATH in
            "$new_path_entry"|"$new_path_entry":*|*:"$new_path_entry"|*:"$new_path_entry":*) ;;
            *) export PATH="$new_path_entry:${PATH}" ;;
        esac
    fi
}

function bashd_add_to_path_back ()
# Useful for adding sbin, /Developer/Tools, or X11.
# Basically, stuff that doesn't need to override existing tools (which may be duplicated or symlinked &c.)
{
    local new_path_entry
    new_path_entry="$1"
    
    if [ -n "$new_path_entry" -a -d "$new_path_entry" ]
    then
        case $PATH in
            "$new_path_entry"|"$new_path_entry":*|*:"$new_path_entry"|*:"$new_path_entry":*) ;;
            *) export PATH="${PATH}:$new_path_entry" ;;
        esac
    fi
}

function bashd_add_to_path_back_if_admin ()
# If user is in admin group, wheel group, or is root, then call bashd_add_to_path_back().
{
    local group
    for group in "${GROUPS[@]}"
    do
        if [ "$group" -eq 80 ] || [ "$group" -eq 0 ] || [ "${USER:-$LOGNAME}" == "root" ]
        then
            bashd_add_to_path_back "$1"
            return # No point in testing for more groups if we've already added it.
        fi
    done
}
