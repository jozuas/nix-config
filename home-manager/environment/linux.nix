{ pkgs, ... }:

{
  imports =
    [
      ./units/common.nix
      ./units/linux/alacritty.nix
      ./units/linux/rofi.nix
      ./units/linux/xdg.nix
    ];

  home.packages = with pkgs; [
    pick-colour-picker
    simplescreenrecorder
    zathura
    android-file-transfer

    gnome3.totem
    gnome3.nautilus
    gnome3.cheese
    transmission-gtk
  ];

  services = {
    unclutter = {
      enable = true;
      package = pkgs.unclutter-xfixes;
    };
  };
}
