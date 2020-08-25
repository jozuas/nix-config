# Manual steps for NixOS setup

### General
1. Touch `variables.env` in the root directory of the project
2. Fill in `NIX_CONFIG_MACHINE`, `NIX_CONFIG_DE`, `NIX_CONFIG_ENV` and `OPENWEATHER_API_KEY`.
3. Run scripts in `scripts/nixos-setup` directory.

### Firefox
Set `layers.acceleration.force-enabled` to `true` to get rid of screen tearing on Firefox.

### i3wm
- Create a keyring named login with Seahorse. Password must be the same as the login password.
- Import manual backups from ~/nix-config/backups

