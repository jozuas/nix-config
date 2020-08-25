{ config, lib, pkgs, ... }:

{
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
    # CLI Tools
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
    nmap
    speedtest-cli
    traceroute
    python38Packages.bpython

    # Programming language tooling
    shellcheck
    shfmt
    nixpkgs-fmt

    # CLI Utilities
    binutils
    xorg.xev
    xorg.xrandr
    xorg.xmodmap
    zip
    unzip
    xclip
    feh

    # GUIs
    jetbrains.idea-ultimate
    vscodium
    transmission-gtk
    zathura
    notable
    bitwarden
    android-file-transfer
    chromium
    tor-browser-bundle-bin
    tdesktop
    skypeforlinux
    discord
    zoom-us
    teamviewer
    spotify

    # Theming
    bibata-cursors
    nerdfonts
  ];

  programs = {
    direnv.enable = true;
    gpg.enable = true;
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
