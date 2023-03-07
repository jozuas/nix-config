{ pkgs, ... }:

let pkgs_unstable = import <nixpkgs-unstable> { };
in {
  imports = [
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
    git-quick-stats
    onefetch
    delta
    ranger
    tldr
    jq
    fd
    neofetch
    wget
    cmatrix
    ssldump
    nmap

    # Doom, Vim
    emacs-all-the-icons-fonts
    python3Packages.pytest
    python3Packages.flake8
    python3Packages.black
    python3Packages.isort
    nodePackages.pyright
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodePackages.typescript-language-server
    nodePackages.typescript # Seems to be needed for DOOM to detect typescript-language-server
    nodePackages.stylelint
    html-tidy
    elvis-erlang
    erlfmt
    pkgs_unstable.erlang-ls
    pkgs_unstable.elixir_ls
    rnix-lsp
    nixfmt
    nix-linter
    hunspell
    hunspellDicts.en-gb-large
    proselint
    ripgrep
    coreutils

    # Programming language tooling
    gnumake
    sqlite
    ## Bash
    shellcheck
    shfmt
    ## Python
    python3
    ## JavaScript
    nodejs
    yarn
    ## Erlang / Elixir
    pkgs_unstable.elixir
    pkgs_unstable.erlangR25
    rebar3
    rebar

    ## Nix
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
