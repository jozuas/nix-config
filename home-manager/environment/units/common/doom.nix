{ pkgs, ... }:

let
  unstable = import <unstable> {};
in {
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/cc6fd96d14c3c7d783b9ed45691dbf7215d1e45e.tar.gz;
  #   }))
  # ];

  # Doom already has a declarative package manager, so it is not managed via Nix
  # use "cachix use nix-community" to prevent recompilations of emacs
  programs.emacs = {
    enable = true;
    # package = pkgs.emacsGcc;
    package = pkgs.emacs;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
