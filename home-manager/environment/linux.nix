{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
  variables = import ~/nix-config/variables.nix;
in {
  imports =
    [
      ./common.nix
      ./units/linux/rofi.nix
      ./units/linux/xdg.nix
    ];

  home.packages = with pkgs; [
    # GUIs
    jetbrains.idea-ultimate
    vscodium
    gimp
    inkscape
    audacity
    libreoffice-fresh
    teamviewer
    teams
    zoom-us
    bitwarden
    chromium
    unstable.tdesktop
    unstable.discord
    firefox-devedition-bin

    youtube-dl
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

  programs = {
    git = {
      userEmail = "norkus@norkus.net";
    };

    zsh = {
      sessionVariables = {
        BROWSER = "${pkgs.chromium}/bin/chromium";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        CDPATH = ".:/home/juozas:/home/juozas/dev:/home/juozas/documents";
        GITHUB_TOKEN = "${variables.GITHUB_TOKEN}";
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "pi" = {
          hostname = "pi";
          user = "juozas";
          port = 42000;
        };
      };
    };
  };
}
