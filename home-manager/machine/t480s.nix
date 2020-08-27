{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty.settings = {
      font.size = 12;
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
    };

    rofi.font = "Ubuntu Light 18";

    git.signing.key = "3C5AA30C300E6439E3D49283DB6D4A68B6AFA263";
  };


  services.dunst.settings = {
    global = {
      font = "Ubuntu Light 14";
    };
  };

  gtk.font.name = "Ubuntu Light 14";
}
