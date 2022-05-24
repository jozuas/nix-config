#!/usr/bin/env bash

# This script and all scripts under ./macos are idempotent

nixpkgs_version="21.11"

bash ./macos/*.sh

ln -sfn ~/nix-config/scripts ~/scripts
ln -sfn ~/nix-config/pictures ~/Pictures/resources

sudo nix-channel --add \
  "https://github.com/nix-community/home-manager/archive/release-${nixpkgs_version}.tar.gz" home-manager
sudo nix-channel --add \
  "https://channels.nixos.org/nixpkgs-${nixpkgs_version}-darwin" nixpkgs
sudo nix-channel --add \
  "https://channels.nixos.org/nixpkgs-unstable" nixpkgs-unstable
sudo nix-channel --update

nix-shell '<home-manager>' -A install
