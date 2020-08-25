{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    fullscreen = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "~/nix-config/dotfiles/rofi-theme.rasi";
  };
}
