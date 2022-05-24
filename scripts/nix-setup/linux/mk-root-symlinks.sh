#!/usr/bin/env bash

sudo rm -rf /etc/nixos
sudo ln -sfn ~/nix-config/nixos /etc/nixos

sudo mkdir -p /usr/share/backgrounds
sudo cp ~/nix-config/resources/backgrounds/forest.jpg /usr/share/backgrounds/background.jpg

# sudo vim theme
sudo mkdir -p /root/.local/share/nvim/site/colors
sudo cp -f ~/nix-config/dotfiles/vim-theme.vim \
  /root/.local/share/nvim/site/colors/vim_theme.vim
sudo mkdir -p /root/.local/share/nvim/site/autoload/airline/themes
sudo cp -f ~/nix-config/dotfiles/airline-theme.vim \
  /root/.local/share/nvim/site/autoload/airline/themes/airline_theme.vim
