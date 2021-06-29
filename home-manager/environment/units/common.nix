{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  imports =
    [
      ./common/bat.nix
      ./common/fzf.nix
      ./common/git.nix
      ./common/irssi.nix
      ./common/neovim.nix
      ./common/tmux.nix
      ./common/zsh.nix
    ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # CLI Tools
    delta
    ngrok
    awscli2
    ranger
    tldr
    jq
    fd
    neofetch
    wget
    nmap
    speedtest-cli
    youtube-dl
    pandoc
    ag

    # Nix tooling
    nix-prefetch-git
    niv
    nox
    manix
    nix-linter
    nixpkgs-fmt
    nixpkgs-review

    # Programming language tooling
    sqlite
    ## Bash
    shellcheck
    shfmt
    ## Python
    python3Full
    pipenv
    poetry
    python3Packages.black
    python3Packages.flake8
    python3Packages.bpython
    # JavaScript
    nodejs
    yarn
    # JVM
    jdk11
    maven
    # Erlang/Elixir
    erlang
    elixir

    # GUIs
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.webstorm
    vscodium
    bitwarden
    chromium
    unstable.tdesktop
    unstable.discord
    gimp
    inkscape
    audacity
    teams
    libreoffice-fresh
    teamviewer
    zoom-us
  ];

  programs = {
    direnv.enable = true;
    direnv.enableNixDirenvIntegration = true;
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
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    lorri.enable = true;
  };
}
