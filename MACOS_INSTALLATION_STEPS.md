# Manual steps for MacOS setup

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer) (the
   Determinate installer enables flakes by default).
2. Clone this repo to `~/nix-config`.
3. On Apple Silicon, install Rosetta 2 (required because the config sets
   `nix-homebrew.enableRosetta = true` to manage the Intel Homebrew prefix):
   ```bash
   softwareupdate --install-rosetta --agree-to-license
   ```
4. Build and switch:
   ```bash
   sudo -H darwin-rebuild switch --flake ~/nix-config#mbp
   ```
   Replace `mbp` with the appropriate `darwinConfigurations.<name>` entry from
   `flake.nix` if setting up a different machine.

Subsequent updates are `nix flake update` (in `~/nix-config`) followed by the
same `darwin-rebuild switch --flake` command.

## Other

- Generate a GPG Key with `gpg --full-generate-key`. Put the signature into the
  machine git config as all commits will be signed with this key.
- Generate an SSH Key with `ssh-keygen -t ed25519 -C "j@norkus.net"`
  and run `ssh-add ~/.ssh/id_ed25519` to add the key into the keychain.
