#!/usr/bin/env bash

mkdir -p ~/.irssi
mkdir -p ~/.openvpn

ln -s ~/.nix-config/dotfiles/irssi.theme ~/.irssi/default.theme
ln -s ~/.nix-config/dotfiles/Informatics-InfNets-AT.ovpn ~/.openvpn/Informatics-InfNets-AT.ovpn

