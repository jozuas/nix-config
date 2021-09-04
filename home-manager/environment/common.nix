{ pkgs, ... }:

let
  unstable = import <unstable> {};
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
    delta
    ranger
    tldr
    jq
    fd
    neofetch
    wget
    pandoc
    ag

    # Doom, Vim
    erlang-ls
    unstable.elvis-erlang
    elixir_ls
    unstable.pyright
    python3Packages.pytest
    python3Packages.black
    python3Packages.isort
    python3Packages.flake8
    python3Packages.bpython
    python3Packages.pyflakes
    nixfmt
    hunspell
    proselint
    nix-linter
    mdl
    ripgrep
    coreutils
    clang

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
