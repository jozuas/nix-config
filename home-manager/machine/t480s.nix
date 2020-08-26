{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty.settings = {
      font.size = 12;
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
    };

    rofi.font = "DejaVuSansMono Nerd Font Book 14";
  };


  services.dunst.settings = {
    global = {
      font = "DejaVuSansMono Nerd Font Book 12";
    };
  };

  gtk.font.name = "DejaVu Sans 10";
}
