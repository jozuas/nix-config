#!/usr/bin/env bash

# Setup symlinks
./mk-root-symlinks.sh
./mk-nixos-symlinks.sh
./mk-home-manager-symlinks.sh
./mk-dotfiles-symlinks.sh

ln -sfn /home/juozas/nix-config/scripts /home/juozas/scripts

mkdir -p /home/juozas/pictures
ln -sfn /home/juozas/nix-config/resources /home/juozas/pictures/resources

# Add home manager and nix-hardware channels
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --update

sudo nixos-rebuild switch

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
sudo nix-channel --update

nix-shell '<home-manager>' -A install

reboot
