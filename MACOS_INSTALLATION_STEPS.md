# Manual steps for MacOS setup

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer) (the
   Determinate installer enables flakes by default).
2. Clone this repo to `~/nix-config`.
3. Link non-Nix-managed dotfiles:
   ```bash
   bash ~/nix-config/scripts/nix-setup/macos/mk-symlinks.sh
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
- Generate an SSH Key with `ssh-keygen -t rsa -b 4096 -C "norkus@norkus.net"`
  and run `ssh-add ~/.ssh/id_rsa` to add the key into the keychain.
- Create password store with `pass init GPG-KEY-ID`
