#!/usr/bin/env bash

mkdir -p ~/.config/

ln -sfn ~/nix-config/scripts ~/scripts

mkdir -p ~/.config/polybar
ln -sfn ~/nix-config/dotfiles/polybar-config ~/.config/polybar/config

mkdir -p ~/.config/i3
ln -sfn ~/nix-config/dotfiles/i3-config ~/.config/i3/config

mkdir -p ~/.config/ranger
ln -sfn ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

mkdir -p ~/.config/deadd
ln -sfn ~/nix-config/dotfiles/deadd.conf ~/.config/deadd/deadd.conf
ln -sfn ~/nix-config/dotfiles/deadd.css ~/.config/deadd/deadd.css

ln -sfn ~/nix-config/dotfiles/xscreensaver-config ~/.xscreensaver

ln -sfn ~/nix-config/resources/backgrounds/forest.jpg ~/.background-image

mkdir -p ~/.local/share/nvim/site/autoload/airline/themes
ln -sfn ~/nix-config/dotfiles/airline-theme.vim \
  ~/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim
