{ pkgs, ... }:

{
  # Doom already has a declarative package manager, so it is not managed via Nix

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
