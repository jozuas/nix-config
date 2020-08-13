# Manual steps for NixOS setup

General:
- run scripts in `scripts/nixos-setup` directory.
  __Modify__ `mk-nixpkgs-symlinks` and `mk-nixos-symlinks` as needed.

Firefox:
- Set `layers.acceleration.force-enabled` to `true` to get rid of screen tearing on Firefox.

i3wm:
- Create a keyring named login with Seahorse. Password must be the same as the login password.
- Import manual backups from ~/nix-config/backups

