#!/usr/bin/env bash

nix-env --delete-generations old
nix-store --gc
nix-collect-garbage -d
sudo nix-channel --update
