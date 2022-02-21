#!/bin/bash


function kcfgp ()
{
    security find-generic-password -gs "$1" 2>&1 | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

function kcfip ()
{
    if [ 1 -eq "${#@}" ]
    then
        security find-internet-password -gs "$1" 2>&1 | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
    elif [ 2 -eq "${#@}" ]
    # This must be a separate call, and not merely ${2:+-a} because security(1) counts its arguments and fails if it gets confused.
    then
        security find-internet-password -gs "$1" -a "$2" 2>&1 | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
    else
        echo "usage: $FUNCNAME service [account]" 1>&2
    fi
}

