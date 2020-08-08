# Manual steps for NixOS setup

General:
- Create symlinks called current.nix in each nixos/nixpkgs config subdirectory

Firefox:
- Set `layers.acceleration.force-enabled` to `true` to get rid of screen tearing on Firefox.

i3wm:
- Create a keyring named login with Seahorse. Password must be the same as the login password.
- Import manual backups from ~/.nix-config/backups

