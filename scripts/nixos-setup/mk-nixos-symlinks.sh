#!/usr/bin/env bash

desktop_dir="/home/juozas/nix-config/nixos/desktop"
sudo ln -sf "${desktop_dir}/i3.nix" "${desktop_dir}/current.nix"

machine_dir="/home/juozas/nix-config/nixos/machine"
sudo ln -sf "${machine_dir}/x220.nix" "${machine_dir}/current.nix"

