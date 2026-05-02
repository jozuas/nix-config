#!/usr/bin/env bash

mkdir -p ~/.config/

ln -sfn ~/nix-config/scripts ~/scripts

mkdir -p ~/.config/ranger
ln -sfn ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

mkdir -p ~/.local/share/nvim/site/autoload/airline/themes
ln -sfn ~/nix-config/dotfiles/airline-theme.vim \
  ~/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim
