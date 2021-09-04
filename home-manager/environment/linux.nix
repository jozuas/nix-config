{ pkgs, ... }:

let
  unstable = import <unstable> {};
  variables = import ~/nix-config/variables.nix;
in {
  imports =
    [
      ./common.nix
      ./units/linux/rofi.nix
      ./units/linux/xdg.nix
    ];

  home.packages = with pkgs; [
    # Stuff that breaks when building on MacOS
    unstable.pyright
    python3Packages.pytest
    python3Packages.black
    python3Packages.isort
    python3Packages.flake8
    python3Packages.bpython
    python3Packages.pyflakes

    ngrok
    awscli2
    nmap
    speedtest-cli

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
    zsh = {
      enableVteIntegration = true;
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

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
