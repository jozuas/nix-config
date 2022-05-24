{ pkgs, ... }:

{
  # Doom already has a declarative package manager, so it is not managed via Nix
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
