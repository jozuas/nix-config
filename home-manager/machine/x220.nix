{ ... }:

{
  programs = {
    alacritty.settings.font.size = 8;

    rofi.font = "Dejavu Sans Book 14";

    git.signing.key = "6D11AC468819E2EA41232CB52FE519DA622AF155";
  };

  services.dunst.settings = {
    global = {
      font = "Dejavu Sans Book 12";
    };
  };

  gtk.font.name = "Dejavu Sans Book 12";
}
