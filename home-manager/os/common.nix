{ pkgs, ... }:

let pkgs_unstable = import <nixpkgs-unstable> { };
in {
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
    # CLI Tools
    pkgs.cloc
    pkgs.delta
    pkgs.ranger
    pkgs.tldr
    pkgs.jq
    pkgs.fd
    pkgs.wget
    # Broken right now
    # ssldump
    pkgs.bind
    pkgs.nmap
    pkgs.sshpass
    pkgs.pstree
    pkgs.ngrok
    pkgs.git-quick-stats
    pkgs_unstable.gh
    pkgs.rclone
    pkgs.mosh
    pkgs.hurl

    # IDE tools
    pkgs.nodePackages.bash-language-server
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.nodePackages.yaml-language-server
    pkgs.nixpkgs-fmt
    pkgs.nixfmt-classic
    pkgs_unstable.nixd
    # hunspell
    # hunspellDicts.en-gb-large
    # proselint
    pkgs.ripgrep
    pkgs.coreutils

    # Programming language tooling
    pkgs.gnumake
    pkgs.sqlite
    ## JavaScript
    pkgs.nodejs
    pkgs.yarn
    ## Erlang / Elixir
    pkgs_unstable.beam.packages.erlang_26.elixir_1_15
    pkgs_unstable.erlang
    pkgs.rebar3
    ## Rust
    pkgs.rustc
    pkgs.cargo
    ## Nix
    pkgs.nixpkgs-review
    pkgs.nix-prefetch-git

    ## Other
    pkgs.ansible
    pkgs_unstable.ansible-lint
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
