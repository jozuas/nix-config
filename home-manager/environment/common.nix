{ pkgs, ... }:

let
  unstable = import <unstable> {};
  private-pkgs = import ../../private-pkgs;
in {
  imports =
    [
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
    private-pkgs.s4

    # Doom, Vim
    unstable.pyright
    python3Packages.pytest
    python3Packages.flake8
    python3Packages.black
    python3Packages.isort
    unstable.erlang-ls
    unstable.elvis-erlang
    unstable.elixir_ls
    unstable.html-tidy
    nixfmt
    hunspell
    hunspellDicts.en-gb-large
    proselint
    nix-linter
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
    nox
    manix
    nixpkgs-fmt
    nix-prefetch-git
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
