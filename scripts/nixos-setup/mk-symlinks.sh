#!/usr/bin/env bash

mkdir -p ~/.config/
ln -sfn ~/nix-config/nixpkgs ~/.config/nixpkgs

mkdir -p ~/.irssi
ln -sf ~/nix-config/dotfiles/irssi.theme ~/.irssi/default.theme

mkdir -p ~/.openvpn
ln -sf ~/nix-config/backups/Informatics-InfNets-AT.ovpn ~/.openvpn/Informatics-InfNets-AT.ovpn

mkdir -p ~/.config/polybar
ln -sf ~/nix-config/dotfiles/polybar-config ~/.config/polybar/config

mkdir -p ~/.config/i3
ln -sf ~/nix-config/dotfiles/i3-config ~/.config/i3/config

mkdir -p ~/.config/ranger
ln -sf ~/nix-config/dotfiles/ranger-config ~/.config/ranger/rc.conf
