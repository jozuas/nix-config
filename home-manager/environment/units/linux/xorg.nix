{ pkgs, ... }:

let private-pkgs = import /home/juozas/nix-config/private-pkgs;
in {
  imports = [ ./xorg/redshift.nix ./xorg/xresources.nix ./xorg/i3.nix ];

  home.packages = with pkgs; [
    private-pkgs.disable-mouse-acceleration

    maim

    arandr
    xclip
    xdotool
    xorg.xev
    xorg.xrandr
    xorg.xmodmap
    xorg.xwininfo
    xorg.xkill
  ];
}
