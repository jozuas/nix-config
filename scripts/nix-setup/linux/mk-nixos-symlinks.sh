#!/usr/bin/env bash

source "${HOME}/nix-config/variables.env"

desktop_dir="${HOME}/nix-config/nixos/desktop"
sudo ln -sf "${desktop_dir}/${NIX_CONFIG_DE}.nix" \
  "${desktop_dir}/current.nix"

machine_dir="${HOME}/nix-config/nixos/machine"
sudo ln -sf "${machine_dir}/${NIX_CONFIG_MACHINE}.nix" \
  "${machine_dir}/current.nix"
