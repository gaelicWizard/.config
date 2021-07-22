#!/bin/bash --fail

if [ "${PROMPT_COMMAND:-}" == "prompt_command_f" ]
then return # short-circuit, nothing to do.
fi

# Initialise:
#  Don't clobber.
#  Avoid "unbound variable" errors.
#  Avoid blank entries.
#  Can't use declare(builtin) since doing so might mark the array as local.
PROMPT_COMMANDS=( "${PROMPT_COMMANDS[@]:-}" )
if [ "${PROMPT_COMMANDS[0]}" == "" ]
then unset PROMPT_COMMANDS[0]
fi

function prompt_command_clear ()
{
    PROMPT_COMMANDS=()
}

function prompt_command_append ()
{
    PROMPT_COMMANDS["${#PROMPT_COMMANDS[@]}"]="$@"
}

function _prompt_command_f ()
{
    local pc
    for pc in "${PROMPT_COMMANDS[@]:-}"
    do 
        eval "$pc"
    done
    return 0
}

PROMPT_COMMAND=_prompt_command_f
readonly PROMPT_COMMAND
