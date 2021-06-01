# README

The `shell.nix` templates in this directory are intended to be used with [nix-direnv](https://github.com/nix-community/nix-direnv).

## How this works

1. Copy the desired `shell.nix` file into the project root directory
2. If there is a `nix` folder, that means [niv](https://github.com/nmattia/niv)
   is used for pinning package versions. In this case copy the whole `nix`
   folder in addition to `shell.nix`.
3. `echo "use nix" > .envrc`
4. If you have `nix-direnv` setup properly, at this point, you should see the
   prompt asking you to run `direnv allow` in your terminal
5. Profit
