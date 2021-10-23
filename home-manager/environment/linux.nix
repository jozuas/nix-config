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
    # Doom
    clang

    # Work Mac flags as malware
    cachix

    # I don't want 10GB of Haskell dependencies on my work laptop
    # ghc
    # ghcid
    # hlint
    # haskellPackages.brittany
    # haskell-language-server

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
    unstable.spotify
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
