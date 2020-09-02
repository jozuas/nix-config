{ pkgs, ... }:

let
  private-pkgs = import /home/juozas/nix-config/private-pkgs;
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
