#!/bin/bash --fail

###
## rc.bash: for use as ~/.bashrc, sourced for interactive, non-login shells.
###


##
# Alias(es) et al which should be available during interactive shells.
##

for rc_mine in  ~/Library/init/bash/*.funcs.bash \
                ~/Library/init/bash/*.aliases.bash \
                ~/Library/init/bash/*.rc.bash
# Load everything for interactive shells, but don't reset inherited environment.
do
    source "$rc_mine"
done
unset rc_mine

return
    # deliberately return early.
