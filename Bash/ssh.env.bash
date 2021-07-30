#!/bin/bash --fail

##
# Clear variables expected to be inaccurate.
unset SSH_HOSTNAME SSH_CLIENT
#

# Reconstruct SSH_HOSTNAME and SSH_CLIENT from SSH_CONNECTION.
if [ -n "${SSH_CONNECTION:-}" ]
then 
	for i in ${SSH_CONNECTION%% *} $(host ${SSH_CONNECTION%% *} 2>/dev/null)
	do
		export SSH_HOSTNAME="$i"
	done; unset i
	export SSH_CLIENT=`echo "$SSH_CONNECTION" | awk '{print $1 " " $2 " " $4}'`
fi
