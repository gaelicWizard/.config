#!/bin/bash --fail

# Figure out the incoming hostname for ssh connections
#  I do this because SSH_CONNECTION is preserved by my environment,
#  whereas SSH_HOSTNAME is not (since it is redundant).
unset SSH_HOSTNAME
if [ -n "${SSH_CONNECTION:-}" ]
then 
    local i
    for i in `host $(echo $SSH_CONNECTION | awk '{print $1}')`; do SSH_HOSTNAME="$i"; done
    export SSH_HOSTNAME
fi

# Reset SSH_CLIENT from SSH_CONNECTION
#  I do this because SSH_CONNECTION is preserved by my environment,
#  whereas SSH_CLIENT is not (since it is redundant).
if [ -n "${SSH_CONNECTION:-}" ]
then
    export SSH_CLIENT=`echo "$SSH_CONNECTION" | awk '{print $1 " " $2 " " $4}'`
fi
