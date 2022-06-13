#!/usr/bin/env bash

ln -sfn ~/nix-config/scripts ~/scripts

mkdir -p ~/.local/share/nvim/site/autoload/airline/themes
ln -sf ~/nix-config/dotfiles/airline-theme.vim \
  ~/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim

mkdir -p ~/.local/share/nvim/site/colors
ln -sf ~/nix-config/dotfiles/vim-theme.vim \
  ~/.local/share/nvim/site/colors/vim_theme.vim

mkdir -p ~/.config/
ln -sfn ~/nix-config/home-manager ~/.config/nixpkgs

mkdir -p ~/.config/polybar
ln -sf ~/nix-config/dotfiles/polybar-config ~/.config/polybar/config

mkdir -p ~/.config/i3
ln -sf ~/nix-config/dotfiles/i3-config ~/.config/i3/config

mkdir -p ~/.config/ranger
ln -sf ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

mkdir -p ~/.config/deadd
ln -sf ~/nix-config/dotfiles/deadd.conf ~/.config/deadd/deadd.conf
ln -sf ~/nix-config/dotfiles/deadd.css ~/.config/deadd/deadd.css

ln -sf ~/nix-config/dotfiles/xscreensaver-config ~/.xscreensaver

ln -sf ~/nix-config/resources/backgrounds/forest.jpg ~/.background-image

ln -sf ~/nix-config/dotfiles/doom ~/.doom.d
