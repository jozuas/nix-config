#!/usr/bin/env bash

# This script and all scripts under ./linux are idempotent

nixpkgs_version="21.11"

bash ./linux/*.sh

mkdir -p /home/juozas/pictures
ln -sfn /home/juozas/nix-config/resources /home/juozas/pictures/resources
ln -sfn /home/juozas/nix-config/scripts /home/juozas/scripts

sudo nix-channel --add \
  "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz" nixos-hardware
sudo nix-channel --add \
  "https://channels.nixos.org/nixos-${nixpkgs_version}" nixpkgs
sudo nix-channel --add \
  "https://channels.nixos.org/nixos-unstable" nixpkgs-unstable
sudo nix-channel --update

sudo nixos-rebuild switch

sudo nix-channel --add \
  "https://github.com/nix-community/home-manager/archive/release-${nixpkgs_version}.tar.gz" home-manager
sudo nix-channel --update

nix-shell '<home-manager>' -A install

echo "Please reboot"
