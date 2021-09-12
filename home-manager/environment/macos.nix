{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  home.packages = with pkgs; [
    htop
    fontconfig
    cmake
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/twlz0ne/nix-gccemacs-darwin/archive/master.zip;
    }))
  ];

  programs = {
    # cachix use gccemacs-darwin
    emacs = {
      package = pkgs.emacsGccDarwin;
    };
  };
}
