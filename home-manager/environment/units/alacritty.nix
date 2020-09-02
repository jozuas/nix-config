{ ... }:

let
  # Temporary, I want Alacritty VI mode
  unstable = import <nixos-unstable> { };
in
{
  programs.alacritty = {
    enable = true;
    package = unstable.alacritty;
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
          background = "0x15161d";
          foreground = "0xfdfdfd";
        };
        normal = {
          black = "0x15161d";
          red = "0xff4971";
          green = "0x89ff49";
          yellow = "0xfffc3d";
          blue = "0x49b0ff";
          magenta = "0xff49cb";
          cyan = "0x18e3c8";
          white = "0xaeb7f5";
        };
        bright = {
          black = "0x4b4f69";
          red = "0xff4971";
          green = "0x89ff49";
          yellow = "0xfffc3d";
          blue = "0x49b0ff";
          magenta = "0xff49cb";
          cyan = "0x18e3c8";
          white = "0xfdfdfd";
        };
      };
      bell = {
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
