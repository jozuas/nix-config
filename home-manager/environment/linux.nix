{ pkgs, ... }:

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
    shellcheck
    shfmt
    nixpkgs-fmt
    nix-linter
    python38Packages.bpython
    jdk11 # JShell

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
    discord
    spotify
    syncthing-gtk

    # Theming
    bibata-cursors
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
