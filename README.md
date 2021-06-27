# .config
My configuration files ("dot files").

This repository was created with a modified technique based on [Nicola Paolucci]( https://www.twitter.com/durdn )'s _[The best way to store your dotfiles]( https://www.atlassian.com/git/tutorials/dotfiles )_.

## Installation

    alias config='git --git-dir="$HOME/Projects/config.git" --work-tree="${XDG_CONFIG_HOME:-$HOME/Library/Preferences}"'  
    git clone --bare https://github.com/gaelicWizard/.config.git ~/Projects/config.git  
    config config --local status.showUntrackedFiles no  

