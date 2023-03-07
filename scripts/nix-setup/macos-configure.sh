#!/usr/bin/env bash

# This script and all scripts under ./macos are idempotent

nixpkgs_version="22.11"

export SETUP_MACHINE="mbp"
export SETUP_OS="macos"
bash ./macos/*.sh

nix-channel --remove home-manager
nix-channel --add \
  "https://github.com/nix-community/home-manager/archive/release-${nixpkgs_version}.tar.gz" home-manager

nix-channel --remove nixpkgs
nix-channel --add \
  "https://channels.nixos.org/nixpkgs-${nixpkgs_version}-darwin" nixpkgs

nix-channel --remove nixpkgs-unstable
nix-channel --add \
  "https://channels.nixos.org/nixpkgs-unstable" nixpkgs-unstable

nix-channel --update
darwin-rebuild switch

# Install DOOM emacs
if [[ ! -d ~/.emacs.d ]]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
fi

echo "Done, please reboot"
