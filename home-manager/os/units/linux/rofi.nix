{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "~/nix-config/dotfiles/rofi-theme.rasi";
    extraConfig = {
      modi = "drun";
      kb-row-up = "Control+k";
      kb-row-down = "Control+j";
      kb-accept-entry = "Return,KP_Enter";
      kb-remove-to-eol = "";
    };
  };
}
