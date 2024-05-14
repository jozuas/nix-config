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
    # ssldump broken right now
    bind
    nmap
    sshpass
    pstree
    ngrok
    git-quick-stats
    pkgs_unstable.gh
    rclone
    mosh

    # IDE tools
    emacs-all-the-icons-fonts
    nodePackages.bash-language-server
    shellcheck
    shfmt
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodePackages.typescript-language-server
    nodePackages.typescript # Seems to be needed for DOOM to detect typescript-language-server
    nodePackages.stylelint
    html-tidy
    # DOOM Emacs/VS Code download their own
    # elvis-erlang
    # erlfmt
    # erlang-ls
    # elixir_ls - 
    nixfmt
    pkgs_unstable.nixd
    hunspell
    hunspellDicts.en-gb-large
    proselint
    ripgrep
    coreutils

    # Programming language tooling
    gnumake
    sqlite
    ## Python
    python3
    ## JavaScript
    nodejs
    yarn
    ## Erlang / Elixir
    pkgs_unstable.beam.packages.erlangR26.elixir_1_15
    pkgs_unstable.erlang
    rebar3
    ## Rust
    rustc
    cargo

    ## Nix
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-git

    ## Other
    ansible
    pkgs_unstable.ansible-lint
    #python311Packages.pip # ansible-lint crashes without pip
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
