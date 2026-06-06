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
    xob

    # TODO: why is this needed?
    networkmanagerapplet

    brillo
    feh
  ];

  programs = {
    git = {
      settings = {
        credential.helper = "libsecret";
      };
    };
  };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
