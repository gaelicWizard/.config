#!/bin/sh -c 'echo This file is meant to be sourced.'

export BROWSER="open" # -a Safari"

alias LaunchCFMApp='/System/Library/Frameworks/Carbon.framework/Versions/Current/Support/LaunchCFMApp' 
    # Code Fragment Management applications can't be run ./app :-)
alias apps="ps x -o command | grep '[ ]-psn_' | sort" # <- shows full path
#ps -xc -o command | egrep -c "^iTunes$" # <- shows name only
    # List all running Aqua applications
alias idle="ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print \$NF/1000000000; exit}'" 
    # This returns the number of seconds since I typed anything or moved the mouse
function DS_clean () { dot_clean -n "$1"; find "$1" -name .DS_Store -delete -print; }
    # Fails on FileVault homes, since dot_clean stops on errors and cannot read ~/.fseventsd
function xml1 () { plutil -convert xml1 "$@"; }
function exclude () { xattr -w com.apple.metadata:com_apple_backup_excludeItem com.apple.backupd "$@"; }

## Aqua/GUI related helpers
function appinfo ()
{
#TODO:FIXME: Convert to use PlistBuddy(1).

    fullAppPath="$(realpath "$1")";

    appName="$(defaults read "${fullAppPath}/Contents/Info" CFBundleName)";
    appID="$(defaults read "${fullAppPath}/Contents/Info" CFBundleIdentifier)";
    appVersion="$(defaults read "${fullAppPath}/Contents/Info" CFBundleVersion)";

    echo "$appName v$appVersion ($appID)";
}


function app () { ps xc -o command | egrep -c "^$*$" ; }
function applscrpt () { osascript -e 'tell application "System Events" to do shell script "'"$*"'"'; }

function ql () { qlmanage -p "$@" >/dev/null ; }

function qapp () 
{   # Use AppleScript to quit a running Aqua application, the application name does not need to be quoted
 
    osascript -e 'tell application "Dock"' -e 'tell application "'"$*"'" to quit' -e 'end tell'
}

function lapp () 
{   # Use AppleScript to launch an Aqua application, the application name need not be quoted
 
    osascript -e 'tell application "Dock"' -e 'launch application "'"$*"'"' -e 'end tell' 
}

function fapp ()
{   # Use perl to find an Aqua application by bundle ID
    perl -MMac::Processes -e 'printf "%s\n", LSFindApplicationForInfo(undef, "'"$1"'")'
}

function carbErr ()
{   # Lookup carbon error codes
    if [ "$1" == "" -o "$2" != "" ];then 
        echo "Usage: $FUNCNAME errno"
    else 
        grep "$1" /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/CarbonCore.framework/Headers/MacErrors.h
    fi
}

function unSetFile ()
{   # Using SetFile from the Apple Developer Tools, reset-to-default all meta data (on an HFS+ file)
    if [ "$1" == "" ]; then 
        echo "Usage: $FUNCNAME file"
    else
        SetFile -a avbstclinmed "$@"
        SetFile -t '' "$@"
        SetFile -c '' "$@"
    fi
}

