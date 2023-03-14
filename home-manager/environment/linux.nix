{ pkgs, ... }:

let
  pkgs_unstable = import <nixpkgs-unstable> { };
  variables = import ./../variables.nix;
  private-pkgs = import ./../private-pkgs;
in {
  imports = [
    ./common.nix
    ./units/linux/alacritty.nix
    ./units/linux/gtk.nix
    ./units/linux/rofi.nix
    ./units/linux/xdg.nix
    ./units/linux/xorg.nix
  ];

  home.packages = with pkgs; [
    # Dev
    ansible

    # Doom
    clang

    # Broken on MacOS
    python3Packages.bpython

    private-pkgs.s4
    ngrok
    awscli2
    nmap
    speedtest-cli

    # GUIs
    obsidian
    spotify
    gimp
    inkscape
    audacity
    libreoffice-fresh
    teamviewer
    teams
    zoom-us
    bitwarden
    chromium
    pkgs_unstable.tdesktop
    # pkgs_unstable.discord
    firefox-devedition-bin
    pkgs_unstable.zeal

    pkgs_unstable.youtube-dl
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
        BROWSER = "${pkgs.firefox-devedition-bin}/bin/firefox-devedition";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        CDPATH = ".:/home/juozas:/home/juozas/dev:/home/juozas/documents";
        GITHUB_TOKEN = "${variables.GITHUB_TOKEN}";
        OPENWEATHER_API_KEY = "${variables.OPENWEATHER_API_KEY}";
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

    tmux = {
      extraConfig = ''
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
      '';
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
