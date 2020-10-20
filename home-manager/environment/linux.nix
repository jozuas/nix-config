{ pkgs, ... }:

let
  private-pkgs = import /home/juozas/nix-config/private-pkgs;
  unstable = import <nixos-unstable> {};
in {
  imports =
    [
      ./units/alacritty.nix
      ./units/bat.nix
      ./units/firefox.nix
      ./units/fzf.nix
      ./units/git.nix
      ./units/irssi.nix
      ./units/neovim.nix
      ./units/rofi.nix
      ./units/tmux.nix
      ./units/zsh.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.packages = with pkgs; [
    # Scripts
    private-pkgs.disable-mouse-acceleration

    # CLI Tools
    screenkey
    ranger
    icdiff
    htop
    tldr
    jq
    fd
    neofetch
    maim
    whois
    curl
    wget
    nmap
    speedtest-cli
    traceroute
    pandoc

    # Programming language tooling
    ## Bash
    shellcheck
    shfmt
    ## Python
    python3
    python3Packages.black
    python3Packages.bandit
    python3Packages.flake8
    python3Packages.bpython
    # JavaScript
    nodejs
    ## Nix
    nixpkgs-fmt
    nix-linter
    pypi2nix
    ## Clojure
    clojure
    leiningen
    ## Erlang
    erlang

    # CLI Utilities
    binutils
    xorg.xev
    xorg.xrandr
    xorg.xmodmap
    xorg.xwininfo
    xorg.xkill
    zip
    unzip
    xclip
    feh

    # GUIs
    jetbrains.idea-ultimate
    vscodium
    transmission-gtk
    zathura
    bitwarden
    android-file-transfer
    chromium
    tor-browser-bundle-bin
    tdesktop
    skypeforlinux
    unstable.discord
    spotify
    syncthing-gtk

    # Theming
    bibata-cursors
  ];

  programs = {
    direnv.enable = true;
    gpg.enable = true;

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
    unclutter = {
      enable = true;
      package = pkgs.unclutter-xfixes;
    };

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    lorri.enable = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "\$HOME/desktop";
      documents = "\$HOME/documents";
      download = "\$HOME/downloads";
      music = "\$HOME/music";
      pictures = "\$HOME/pictures";
      videos = "\$HOME/videos";
      templates = "\$HOME/templates";
      publicShare = "\$HOME/public";
    };
  };
}
