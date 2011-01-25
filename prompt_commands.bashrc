#!/bin/bash --fail

declare -a PROMPT_COMMANDS=()

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
    for pc in "${PROMPT_COMMANDS[@]:-}"
    do 
        $pc
            # $pc is not quoted so that entire command lines can be specified in a single entry of PROMPT_COMMANDS
            # Should prolly use eval.
    done
}

{
  # This declaration must go within braces in order to be able to silence
  # readonly variable error.
    PROMPT_COMMAND=prompt_command_f
} 2>/dev/null
readonly PROMPT_COMMAND
