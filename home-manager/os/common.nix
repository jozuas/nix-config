{ config, pkgs, pkgs-unstable, ... }:

let
  private_pkgs = import ./../private-pkgs;

  # Live-symlink to a path inside the cloned nix-config repo (assumed at ~/nix-config).
  # Edits apply immediately without a home-manager rebuild.
  repoLink = path:
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/${path}";
in
{
  home.file."scripts".source = repoLink "scripts";

  xdg.configFile."ranger/rc.conf".source = repoLink "dotfiles/ranger-config";
  xdg.dataFile."nvim/site/autoload/airline/themes/airline_theme.vim".source =
    repoLink "dotfiles/airline-theme.vim";

  imports = [
    ./units/common/bat.nix
    ./units/common/fzf.nix
    ./units/common/git.nix
    ./units/common/neovim.nix
    ./units/common/tmux.nix
    ./units/common/zsh.nix
  ];

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
    pkgs-unstable.gh
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
    pkgs-unstable.beam.packages.erlang_27.elixir_1_18
    pkgs-unstable.elixir-ls
    pkgs.rebar3
    ## Nix
    pkgs.nixfmt-rfc-style
    pkgs.nixpkgs-review
    pkgs.nix-prefetch-git
    pkgs-unstable.nixd
    ##
    pkgs-unstable.cargo
    pkgs-unstable.rustc
    pkgs-unstable.rust-analyzer
    pkgs-unstable.rustfmt
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
