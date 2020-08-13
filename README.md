# nix-config
My NixOS, Home Manager configuration and dotfiles 

## What is NixOS?
[NixOS](https://nixos.org/) is a Linux distribution built around the Nix purely functional package manager.

## What is Home Manager?
[Home Manager](https://github.com/rycee/home-manager) is NixOS for your home folder.
That is, NixOS manages the operating system and system-wide configuration, home-manager manages the home folder (dotfiles).

## Why would anyone use this set-up?
- Reproducible system configuration. I could throw my computer out of the window,
  buy a new one and have an identical environment in an hour or so.
- Trivial to do configuration rollbacks - can rollback on boot as well as in real-time.
  No fear breaking anything!
- The system is always in it's most minimal version, only the declared packages are installed.
  Oh, you have 10GB of Android dev dependencies and you're not even doing Android anymore?
  Not on my system.
- Isolated DEV environments for any software stack with Nix user environments (`nix-env`).
  Imagine Python `virtualenv`, but on steroids - in addition to declaring language libraries,
  declare binary packages and build scripts for building from source (and more).
- Can install multiple versions of the same package via different nix environments (`nix-env`).
  Imagine running multiple versions of MySQL at the same time!
- Most software installed locally. Sensible, isn't it?
- Portability - Nix and Home Manager are supported on MacOS/any Linux/BSD/,
  which allows for intricate configuration sharing between different OSes.
- Nix User Repository - like Arch User Repository.
- Source and binary packages.

