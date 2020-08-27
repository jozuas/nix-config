{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty.settings.font.size = 8;

    rofi.font = "Ubuntu Light 14";

    git.signing.key = "6D11AC468819E2EA41232CB52FE519DA622AF155";
  };

  services.dunst.settings = {
    global = {
      font = "Ubuntu Light 12";
    };
  };

  gtk.font.name = "Ubuntu Light 12";
}
