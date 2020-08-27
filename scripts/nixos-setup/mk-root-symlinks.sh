#!/usr/bin/env bash

sudo rm -rf /etc/nixos
sudo ln -sfn ~/nix-config/nixos /etc/nixos

sudo mkdir -p /usr/share/backgrounds
sudo cp ~/nix-config/resources/backgrounds/* /usr/share/backgrounds/
