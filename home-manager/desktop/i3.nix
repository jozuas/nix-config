{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./units/xresources.nix
      ./units/gtk.nix
      ./units/dunst.nix
      ./units/redshift.nix
    ];

  home.packages = with pkgs; [
    pamixer
    polybarFull
    xss-lock
    lightlocker
    copyq
    arandr
    xdotool
    copyq
    playerctl
    pavucontrol
    picom
    libnotify
    gnome3.nautilus
  ];

  programs = {
    git = {
      extraConfig = {
        credential.helper = "libsecret";
      };
    };
  };

  services = {
    blueman-applet.enable = true;

    network-manager-applet.enable = true;
  };
}
