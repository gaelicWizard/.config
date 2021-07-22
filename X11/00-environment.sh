#!/bin/sh
: ${X11_PREFS_DOMAIN:=org.Xquartz.X11}

cd ~ # go home

. /Library/GNUstep/Makefiles/GNUstep.sh
#export WMAKER_USER_ROOT=~
: "${GNUSTEP_USER_DEFAULTS_DIR:=$(gnustep-config --variable=GNUSTEP_USER_DEFAULTS_DIR)}"
#: "${GNUSTEP_USER_LIBRARY:=$(gnustep-config --variable=GNUSTEP_USER_LIBRARY)}"
: "${USERSH:=$(defaults read "${X11_PREFS_DOMAIN}" login_shell 2>/dev/null)}"
: "${USERWM:=$(defaults read "${X11_PREFS_DOMAIN}" wm_path 2>/dev/null)}"

if [ -d "${GNUSTEP_USER_DEFAULTS_DIR:=Library/Preferences}" ]
then
	export GNUSTEP_USER_DEFAULTS_DIR
fi

unset GNUSTEP_USER_LIBRARY # arg

if [ -n "${USERSH:-}" ]
then
	export SHELL="${USERSH:-sh}"
else
	unset USERSH
fi
if [ -z "${USERWM:-}" ]
then
	unset USERWM
fi
