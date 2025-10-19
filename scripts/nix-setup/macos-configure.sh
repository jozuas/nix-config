#!/usr/bin/env bash

# This script and all scripts under ./macos are idempotent

nixpkgs_version="25.05"

export SETUP_MACHINE="mbp"
export SETUP_OS="macos"
bash ./macos/*.sh

sudo nix-channel --remove home-manager
sudo nix-channel --add \
  "https://github.com/nix-community/home-manager/archive/release-${nixpkgs_version}.tar.gz" home-manager

sudo nix-channel --remove nixpkgs
sudo nix-channel --add \
  "https://channels.nixos.org/nixpkgs-${nixpkgs_version}-darwin" nixpkgs

sudo nix-channel --remove nixpkgs-unstable
sudo nix-channel --add \
  "https://channels.nixos.org/nixpkgs-unstable" nixpkgs-unstable

sudo nix-channel --update
sudo darwin-rebuild switch

echo "Done, please reboot"
