#!/bin/bash --fail

declare -a PROMPT_COMMANDS

function prompt_command_clear ()
{
    PROMPT_COMMANDS=()
}

function prompt_command_append ()
{
    PROMPT_COMMANDS[${#PROMPT_COMMANDS[@]:-0}]="$@"
}

function prompt_command_f ()
{
    local pc
    if [ -n "${PROMPT_COMMANDS:-}" ]
    then
        # Don't try to do anything, if there's nothing to do!
        # The for loop will do this automatically, but I want to silence complaint that ${PROMPT_COMMANDS} is unbound in that case...
        for pc in "${PROMPT_COMMANDS[@]}"
        do 
            $pc
                # $pc is not quoted so that entire command lines can be specified in a single entry of PROMPT_COMMANDS
                # Should prolly use eval.
        done
    fi
}

PROMPT_COMMAND=prompt_command_f
declare -r PROMPT_COMMAND
