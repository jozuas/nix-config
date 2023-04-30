{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
