#!/bin/bash --fail

##
# Clear variables expected to be inaccurate.
unset SSH_HOSTNAME SSH_CLIENT
#

# Reconstruct SSH_HOSTNAME from SSH_CONNECTION.
if [ -n "${SSH_CONNECTION:-}" ]
then 
	for i in "${SSH_CONNECTION%% *}" "$(host ${SSH_CONNECTION%% *} 2>/dev/null)"
	do
		SSH_HOSTNAME="$i"
	done
	export SSH_HOSTNAME
fi; unset i

# Reconstruct SSH_CLIENT from SSH_CONNECTION
if [ -n "${SSH_CONNECTION:-}" ]
then
	export SSH_CLIENT=`echo "$SSH_CONNECTION" | awk '{print $1 " " $2 " " $4}'`
fi
