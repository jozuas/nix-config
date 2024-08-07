#!/usr/bin/env bash

# This script and all scripts under ./linux are idempotent

nixpkgs_version="23.05"

export SETUP_MACHINE="t480s"
export SETUP_OS="linux"
bash ./linux/*.sh

sudo nix-channel --remove nixos-hardware
sudo nix-channel --add \
  "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz" nixos-hardware

sudo nix-channel --remove nixos
sudo nix-channel --add \
  "https://channels.nixos.org/nixos-${nixpkgs_version}" nixos

sudo nix-channel --remove nixpkgs
sudo nix-channel --add \
  "https://channels.nixos.org/nixos-${nixpkgs_version}" nixpkgs

sudo nix-channel --remove nixpkgs-unstable
sudo nix-channel --add \
  "https://channels.nixos.org/nixos-unstable" nixpkgs-unstable

sudo nix-channel --remove home-manager
sudo nix-channel --add \
  "https://github.com/nix-community/home-manager/archive/release-${nixpkgs_version}.tar.gz" home-manager

sudo nix-channel --update
sudo nixos-rebuild switch

echo "Done, please reboot"
