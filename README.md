# .config
My configuration files ("dot files").

This repository was created with a modified technique based on [Nicola Paolucci]( https://www.twitter.com/durdn )'s _[The best way to store your dotfiles]( https://www.atlassian.com/git/tutorials/dotfiles )_.

## Installation

    alias config='git --git-dir="$HOME/Projects/config.git" --work-tree="${XDG_CONFIG_HOME:-$HOME/Library/Preferences}"'  
    git clone --bare https://github.com/gaelicWizard/.config.git ~/Projects/config.git  
    config config --local status.showUntrackedFiles no  
    config update-index --skip-worktree README.md  

## References

durdn-bb.cfg    https://bitbucket.org/durdn/cfg.git
durdn-gh.cfg    https://github.com/durdn/cfg.git
sjl.dotfiles    https://hg.stevelosh.com/dotfiles
skwp.dotfiles   https://github.com/skwp/dotfiles.git

