{ pkgs, ... }:

let
  unstable = import <unstable> {};
in {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Doom already has a declarative package manager, so it is not managed via Nix
  # use "cachix use nix-community" to prevent recompilations of emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
