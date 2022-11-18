#!/usr/bin/env bash

mkdir -p ~/.nixpkgs/
ln -sfn ~/nix-config/nix-darwin/darwin-configuration.nix ~/.nixpkgs/

mkdir -p ~/.config/
ln -sfn ~/nix-config/home-manager ~/.config/nixpkgs

ln -sfn "${HOME}/.config/nixpkgs/environment/${SETUP_OS}.nix" ~/.config/nixpkgs/environment/current.nix
ln -sfn "${HOME}/.config/nixpkgs/machine/${SETUP_MACHINE}.nix" ~/.config/nixpkgs/machine/current.nix

ln -sfn ~/nix-config/scripts ~/scripts

ln -sfn ~/nix-config/dotfiles/doom ~/.doom.d

mkdir -p ~/.config/ranger
ln -sfn ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

mkdir -p ~/.local/share/nvim/site/autoload/airline/themes
ln -sfn ~/nix-config/dotfiles/airline-theme.vim \
  ~/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim

mkdir -p ~/.local/share/nvim/site/colors
ln -sfn ~/nix-config/dotfiles/vim-theme.vim \
  ~/.local/share/nvim/site/colors/vim_theme.vim

