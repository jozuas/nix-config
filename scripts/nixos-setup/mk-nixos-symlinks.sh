#!/usr/bin/env bash

source /home/juozas/nix-config/variables.env

desktop_dir="/home/juozas/nix-config/nixos/desktop"
sudo ln -sf "${desktop_dir}/${NIX_CONFIG_DE}.nix" \
  "${desktop_dir}/current.nix"

machine_dir="/home/juozas/nix-config/nixos/machine"
sudo ln -sf "${machine_dir}/${NIX_CONFIG_MACHINE}.nix" \
  "${machine_dir}/current.nix"
