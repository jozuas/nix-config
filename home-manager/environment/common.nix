{ pkgs, ... }:

let
  pkgs_unstable = import <nixpkgs-unstable> {};
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

    # Doom, Vim
    pkgs_unstable.pyright
    python3Packages.pytest
    python3Packages.flake8
    python3Packages.black
    python3Packages.isort
    pkgs_unstable.erlang-ls
    pkgs_unstable.elvis-erlang
    pkgs_unstable.elixir_ls
    pkgs_unstable.ccls
    pkgs_unstable.html-tidy
    nixfmt
    hunspell
    hunspellDicts.en-gb-large
    proselint
    nix-linter
    ripgrep
    coreutils

    # Programming language tooling
    gnumake
    sqlite
    ## Bash
    shellcheck
    shfmt
    ## Python
    python3Full
    ## JavaScript
    nodejs
    yarn
    ## Erlang / Elixir
    pkgs_unstable.elixir
    pkgs_unstable.erlang
    rebar3
    rebar

    ## Nix
    nox
    pkgs_unstable.comma
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
