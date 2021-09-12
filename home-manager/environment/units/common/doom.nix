{ pkgs, ... }:

let
  unstable = import <unstable> {};
in {
  # Doom already has a declarative package manager, so it is not managed via Nix
  programs.emacs = {
    enable = true;
    # package = pkgs.emacsGcc;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
