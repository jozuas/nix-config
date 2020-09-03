{ pkgs, ... }:

let
  private-pkgs = import /home/juozas/nix-config/private-pkgs;
  unstable = import <nixos-unstable> {};
in {
  imports =
    [
      ./units/xresources.nix
      ./units/gtk.nix
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

    private-pkgs.deadd-notification-center

    unstable.xob
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
