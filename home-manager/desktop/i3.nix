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
    xscreensaver
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
    mpv = {
      enable = true;

      # From Arch wiki
      config = {
        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        video-sync = "display-resample";
        tscale = "oversample";
        interpolation = true;
      };
    };
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
