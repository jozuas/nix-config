{ config, lib, pkgs, ... }:

let
  background = "0x15161d";
  foreground = "0xfdfdfd";

  black = "0x15161d";
  red = "0xff4971";
  green = "0x89ff49";
  yellow = "0xfffc3d";
  blue = "0x49b0ff";
  magenta = "0xff49cb";
  cyan = "0x18e3c8";
  white = "0xaeb7f5";

  brightBlack = "0x4b4f69";
  brightRed = "0xff4971";
  brightGreen = "0x89ff49";
  brightYellow = "0xfffc3d";
  brightBlue = "0x49b0ff";
  brightMagenta = "0xff49cb";
  brightCyan = "0x18e3c8";
  brightWhite = "0xfdfdfd";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 4;
          y = 5;
        };
        title = "Terminal";
      };
      font = {
        family = "DejaVuSansMono Nerd";
        style = "Book";
        bold_style = "Bold";
        italic_style = "Italic";
        offset = {
          x = 0;
          y = 0;
        };
      };
      colors = {
        primary = {
          background = background;
          foreground = foreground;
        };
        normal = {
          black = black;
          red = red;
          green = green;
          yellow = yellow;
          blue = blue;
          magenta = magenta;
          cyan = cyan;
          white = white;
        };
        bright = {
          black = brightBlack;
          red = brightRed;
          green = brightGreen;
          yellow = brightYellow;
          blue = brightBlue;
          magenta = brightMagenta;
          cyan = brightCyan;
          white = brightWhite;
        };
      };
      visual_bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };
      cursor = {
        style = "Beam";
        unfocused_hollow = true;
      };
      selection.semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      background_opacity = 1.0;
      scrolling.history = 10000;
      live_config_reload = true;
      mouse.url.launcher = "xdg-open";
      draw_bold_text_with_bright_colors = true;
    };
  };
}
