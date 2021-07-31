{ pkgs, ... }:

{
  # Doom already has a declarative package manager, so it is not managed via Nix
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  # Doom Emacs dependencies
  home.packages = with pkgs; [
    ripgrep
    coreutils
    fd
    clang

    # spell checker
    hunspell

    # Nix
    nixfmt

    # Erlang
    erlang-ls

    # Markdown
    mdl
    proselint
    pandoc
  ];
}
