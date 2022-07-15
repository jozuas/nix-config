{ pkgs, ... }:

{
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

    bibata-cursors
    light
    feh
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
