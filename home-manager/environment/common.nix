{ pkgs, ... }:

let
  unstable = import <unstable> {};
  private-pkgs = import ../../private-pkgs;
in {
  imports =
    [
      ./units/common/alacritty.nix
      ./units/common/bat.nix
      ./units/common/doom.nix
      ./units/common/fzf.nix
      ./units/common/git.nix
      ./units/common/neovim.nix
      ./units/common/tmux.nix
      ./units/common/zsh.nix
    ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # CLI Tools
    cloc
    delta
    ranger
    tldr
    jq
    fd
    neofetch
    wget
    pandoc
    ag
    private-pkgs.s4

    # Doom, Vim
    unstable.pyright
    python3Packages.pytest
    python3Packages.pyflakes
    python3Packages.flake8
    python3Packages.black
    python3Packages.isort
    unstable.erlang-ls
    unstable.elvis-erlang
    unstable.elixir_ls
    unstable.html-tidy
    nixfmt
    hunspell
    proselint
    nix-linter
    mdl
    ripgrep
    coreutils

    # Programming language tooling
    gnumake
    docker-compose
    sqlite
    ## Bash
    shellcheck
    shfmt
    ## Python
    python3Full
    poetry
    ## JavaScript
    nodejs
    yarn
    ## Erlang / Elixir
    elixir
    erlang
    rebar3
    rebar

    ## Nix
    nix-prefetch-git
    niv
    nox
    manix
    nixpkgs-fmt
    nixpkgs-review
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    gpg.enable = true;
  };
}
