#!/bin/sh

##
# This package enables the use of macports, optionally.
##
# Once the port command is issued, then macports will be available.
##

declare -F bashd_add_to_path_back >/dev/null || { echo "macports: Unable to manipulate path." 1>&2; return; }

MacPorts="/opt/macports"
if [ ! -d "$MacPorts" ]
then
    MacPorts="/opt/local"
fi

alias port="
    bashd_add_to_path_back $MacPorts/bin
    bashd_add_to_path_back_if_admin $MacPorts/sbin
    port"
