{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  # Doom already has a declarative package manager, so it is not managed via Nix
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.emacs-vterm ];
  };
}
