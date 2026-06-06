{
  pkgs,
  ...
}:

{
  home.file."scripts".source = ../../scripts;

  xdg.configFile."ghostty/config.ghostty".source = ../../dotfiles/config.ghostty;
  xdg.dataFile."nvim/site/autoload/airline/themes/airline_theme.vim".source =
    ../../dotfiles/airline-theme.vim;

  imports = [
    ./units/common/bat.nix
    ./units/common/fzf.nix
    ./units/common/git.nix
    ./units/common/neovim.nix
    ./units/common/tmux.nix
    ./units/common/zsh.nix
  ];

  home.packages = [
    # CLI Tools
    pkgs.cloc
    pkgs.delta
    pkgs.yazi
    pkgs.jq
    pkgs.fd
    pkgs.wget
    pkgs.ripgrep
    pkgs.ssldump
    pkgs.bind
    pkgs.nmap
    pkgs.pstree
    pkgs.git-quick-stats
    pkgs.s5cmd
    pkgs.rclone
    pkgs.mosh
    pkgs.hurl
    pkgs.zstd
    pkgs.htop

    # IDE tools
    pkgs.yaml-language-server
    pkgs.coreutils

    # Programming language tooling
    pkgs.gnumake
    pkgs.sqlite
    ## Bash
    pkgs.bash-language-server
    pkgs.shellcheck
    pkgs.shfmt
    ## JavaScript
    pkgs.nodejs
    pkgs.pnpm
    ## Erlang / Elixir
    pkgs.unstable.beam.packages.erlang_28.elixir_1_19
    pkgs.unstable.elixir-ls
    pkgs.rebar3
    ## Nix
    pkgs.nixfmt
    pkgs.nixpkgs-review
    pkgs.nix-prefetch-git
    pkgs.unstable.nixd
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
