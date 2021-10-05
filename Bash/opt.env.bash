#!/bin/bash

declare -F pathmunge >/dev/null || { echo "opt: Unable to manipulate path." 1>&2; return; }

for optPack in /opt/*
do
	if [ "$optPack" == "/opt/macports" ] || [ "$optPack" == "/opt/local" ]
	then continue # Ignore MacPorts.
	fi

	if [ -d "$optPack" ]
		then
		if [ -d $optPack/bin ]
		then
			pathmunge "$optPack/bin" after
		fi
		if [ -d $optPack/sbin ]
		then
			pathmunge "$optPack/sbin" after
		fi
		if [ -d $optPack/share/aclocal ]
		then
			export ACLOCAL_FLAGS="-I $optPack/share/aclocal${ACLOCAL_FLAGS:+ }${ACLOCAL_FLAGS:-}"
			#TODO:FIXME: $ACLOCAL_FLAGS is invalid in the event of a space in $optPack.
		fi
		if [ -d $optPack/lib/pkgconfig ]
		then
			export PKG_CONFIG_PATH="$optPack/lib/pkgconfig/${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH:-}"
		fi
	fi
done; unset optPack
