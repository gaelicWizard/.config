#!/bin/bash --fail

###
## profile.bash: for use as ~/.bash_profile, sourced for login shells.
###

##
# Environment which should be set once and inherited.
##

if [ -z "${MAC_ENV_IS_LOADED:-}" ]
# Some environment is stored elsewhere.
then
    eval "$(defaults read ~/.MacOSX/environment | fgrep '=' | sed -e 's/ = /=/g' -e 's/^/export /g')"
fi
export MAC_ENV_IS_LOADED=yes # this should have already been set by the above.

for functions_mine in ~/.config/Bash/*.funcs.bash
# Load helper functions.
do
    source "$functions_mine"
done; unset functions_mine

for env_mine in ~/.config/Bash/*.env.bash
# Run environment generating modules.
do
    source "$env_mine"
done; unset env_mine

# If interactive, then switch to bashrc.
case $- in *i*)
    source ~/.bashrc
    return # stop
    ;;
esac
