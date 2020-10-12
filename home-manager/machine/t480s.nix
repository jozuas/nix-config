{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice-fresh
    gimp
    teams
    youtube-dl
  ];

  programs = {
    alacritty.settings = {
      font.size = 12;
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
    };

    rofi.font = "Dejavu Sans Book 18";

    git.signing.key = "3C5AA30C300E6439E3D49283DB6D4A68B6AFA263";
  };


  services.dunst.settings = {
    global = {
      font = "Dejavu Sans Book 14";
    };
  };

  gtk.font.name = "Dejavu Sans Book 14";
}
