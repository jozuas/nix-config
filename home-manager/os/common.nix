{ pkgs, ... }:

let
  private_pkgs = import ./../private-pkgs;

  pkgs_unstable = import <nixpkgs-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  imports = [
    ./units/common/bat.nix
    ./units/common/fzf.nix
    ./units/common/git.nix
    ./units/common/neovim.nix
    ./units/common/tmux.nix
    ./units/common/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # (pkgs.azure-cli.withExtensions [ pkgs.azure-cli-extensions.image-copy-extension ])

    # CLI Tools
    pkgs.cloc
    pkgs.delta
    pkgs.ranger
    pkgs.jq
    pkgs.fd
    pkgs.wget
    pkgs.ripgrep
    # Broken right now
    # ssldump
    pkgs.bind
    pkgs.nmap
    pkgs.pstree
    pkgs.git-quick-stats
    pkgs_unstable.gh
    pkgs.s5cmd
    pkgs.rclone
    pkgs.mosh
    pkgs.hurl
    pkgs.zstd

    # IDE tools
    pkgs.nodePackages.yaml-language-server
    pkgs.coreutils

    # Programming language tooling
    pkgs.gnumake
    pkgs.sqlite
    ## Bash
    pkgs.nodePackages.bash-language-server
    pkgs.shellcheck
    pkgs.shfmt
    ## JavaScript
    pkgs.nodejs
    pkgs.yarn
    ## Erlang / Elixir
    pkgs_unstable.beam.packages.erlang_27.elixir_1_18
    pkgs_unstable.elixir-ls
    pkgs.rebar3
    ## Nix
    pkgs.nixfmt-rfc-style
    pkgs.nixpkgs-review
    pkgs.nix-prefetch-git
    pkgs_unstable.nixd
    ##
    pkgs_unstable.cargo
    pkgs_unstable.rustc
    pkgs_unstable.rust-analyzer
    pkgs_unstable.rustfmt
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    gpg.enable = true;

    password-store = {
      enable = true;
      package = pkgs.pass;
    };
  };
}
