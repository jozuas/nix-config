#!/usr/bin/env bash

mkdir -p ~/.nixpkgs/
ln -sfn ~/nix-config/nix-darwin/darwin-configuration.nix ~/.nixpkgs/

mkdir -p ~/.config/
ln -sfn ~/nix-config/home-manager ~/.config/nixpkgs

ln -sfn "${HOME}/.config/nixpkgs/os/${SETUP_OS}.nix" ~/.config/nixpkgs/os/current.nix
ln -sfn "${HOME}/.config/nixpkgs/machine/${SETUP_MACHINE}.nix" ~/.config/nixpkgs/machine/current.nix

ln -sfn ~/nix-config/scripts ~/scripts

ln -sfn ~/nix-config/dotfiles/doom ~/.doom.d

mkdir -p ~/.config/ranger
ln -sfn ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf

mkdir -p ~/.local/share/nvim/site/autoload/airline/themes
ln -sfn ~/nix-config/dotfiles/airline-theme.vim \
  ~/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim
