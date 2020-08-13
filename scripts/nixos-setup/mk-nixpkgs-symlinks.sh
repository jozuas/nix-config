#!/usr/bin/env bash

desktop_dir="/home/juozas/nix-config/nixpkgs/desktop"
ln -sf "${desktop_dir}/i3.nix" "${desktop_dir}/current.nix"

machine_dir="/home/juozas/nix-config/nixpkgs/machine"
ln -sf "${machine_dir}/x220.nix" "${machine_dir}/current.nix"

user_dir="/home/juozas/nix-config/nixpkgs/user"
ln -sf "${user_dir}/juozas.nix" "${user_dir}/current.nix"

