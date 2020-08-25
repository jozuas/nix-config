{ config, lib, pkgs, ... }:

{
  programs.alacritty.settings.font.size = 8;
  programs.rofi.font = "DejaVuSansMono Nerd Font Book 14";

  services.dunst.settings = {
    global = {
      font = "DejaVuSansMono Nerd Font Book 12";
    };
  };

  gtk.font.name = "DejaVu Sans 10";
}
