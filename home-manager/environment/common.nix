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
    git-quick-stats
    delta
    ranger
    tldr
    jq
    fd
    neofetch
    wget
    ssldump
    bind
    nmap
    sshpass
    pstree

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
    pkgs_unstable.elixir
    pkgs_unstable.erlang
    rebar3
    ## Rust
    rustc
    cargo

    ## Nix
    pkgs_unstable.comma
    nixpkgs-fmt
    nix-prefetch-git
    nixpkgs-review

    ## Other
    ansible
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
