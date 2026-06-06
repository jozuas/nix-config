_:

{
  programs = {
    alacritty.settings = {
      font.size = 12;
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
    };

    rofi.font = "Dejavu Sans Book 18";

    git = {
      settings.user.email = "j@norkus.net";
    };
  };

  gtk.font.name = "Dejavu Sans Book 14";
}
