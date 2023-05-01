# Manual steps for MacOS setup

1. Install [Nix](https://nixos.org/download.html#nix-install-macos)
1. Install [nix-darwin](https://github.com/LnL7/nix-darwin)
1. Modify ENV vars and run `scripts/nix-setup/macos-configure.sh`

## Other

- Generate a GPG Key with `gpg --full-generate-key`. Put the signature into the
  machine git config as all commits will be signed with this key.
- Generate an SSH Key with `ssh-keygen -t rsa -b 4096 -C "norkus@norkus.net`
  and run `ssh-add ~/.ssh/id_rsa` to add the key into the keychain.
- Import manual backups from ~/nix-config/backups
- Create password store with `pass init GPG-KEY-ID`

