#!/usr/bin/env bash

sudo rm -rf /etc/nixos
sudo ln -sfn ~/nix-config/nixos /etc/nixos

sudo mkdir -p /usr/share/backgrounds
sudo cp ~/pictures/resources/backgrounds/forest.jpg /usr/share/backgrounds/background.jpg
