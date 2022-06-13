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

mkdir -p ~/.config/ranger
ln -sf ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

ln -sf ~/nix-config/dotfiles/doom ~/.doom.d
