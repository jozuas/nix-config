{ pkgs, ... }:

{
  imports =
    [
      ./units/common.nix
      ./units/gtk.nix
      ./units/xorg.nix
    ];

  home.packages = with pkgs; [
    xscreensaver
    xss-lock

    pamixer
    playerctl
    pavucontrol
    libnotify

    picom
    copyq
    polybarFull
    deadd-notification-center
    xob
  ];

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
