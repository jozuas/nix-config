# nix-config
My NixOS, Home Manager configuration and dotfiles 

## What is NixOS?
[NixOS](https://nixos.org/) is a Linux distribution built around the Nix purely functional package manager.

## What is Home Manager?
[Home Manager](https://github.com/rycee/home-manager) is NixOS for your home folder. That is, NixOS manages the operating system and system-wide configuration, home-manager manages the home folder (dotfiles).

## Why would anyone use this set-up?
- Reproducible system configuration.
- Easy rollbacks if things go wrong throughout the whole system.
- The system is always the most minimal version.
- Isolated dev environments for any software stack with Nix user environments (`nix-env`). Like Python `virtualenv`, but on steroids.
- Nix User Repository (like Arch User Repository).
- Source and binary packages.
- Can install multiple versions of the same package, imagine running multiple versions of MySQL at the same time!
- Software installed locally.
- Portability - Nix and Home Manager are supported on MacOS/any Linux/BSD/, which allows for intricate configuration sharing.

You should try it too! :smirk:
