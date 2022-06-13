{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "~/nix-config/dotfiles/rofi-theme.rasi";
  };
}
