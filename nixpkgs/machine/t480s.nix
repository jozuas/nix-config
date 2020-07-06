{ config, lib, pkgs, ... }:

{
  programs.alacritty.settings = {
    font.size = 12;
    env = {
      WINIT_X11_SCALE_FACTOR = "1";
    };
  };
}
