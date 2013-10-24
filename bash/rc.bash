#!/bin/bash --fail

###
## rc.bash: for use as ~/.bashrc, sourced for interactive, non-login shells.
###


##
# Alias(es) et al which should be available during interactive shells.
##

for rc_mine in  ~/.config/Bash/*.funcs.bash \
                ~/.config/Bash/*.aliases.bash \
                ~/.config/Bash/*.rc.bash
# Load everything for interactive shells, but don't reset inherited environment.
do
    source "$rc_mine"
done; unset rc_mine

return
    # deliberately return early.
