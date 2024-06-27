{ pkgs, ... }:

let private-pkgs = import ./../../../private-pkgs;
in {
  imports = [ ./xorg/redshift.nix ./xorg/xresources.nix ./xorg/i3.nix ];

  home.packages = [
    private-pkgs.disable-mouse-acceleration

    pkgs.maim

    pkgs.arandr
    pkgs.xclip
    pkgs.xdotool
    pkgs.xorg.xev
    pkgs.xorg.xrandr
    pkgs.xorg.xmodmap
    pkgs.xorg.xwininfo
    pkgs.xorg.xkill
  ];
}
