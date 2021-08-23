{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  # Doom already has a declarative package manager, so it is not managed via Nix
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.emacs-libvterm ];
  };

  # Doom Emacs dependencies
  home.packages = with pkgs; [
    ripgrep
    coreutils
    fd
    clang

    # spell checker
    # TODO this, for e.g. is used in vim as well
    # TODO ag is used by projectile ...
    hunspell

    # Nix
    nixfmt

    # Erlang/Elixir
    erlang-ls
    elixir_ls

    # Markdown
    mdl
    proselint
    pandoc

    # Python
    unstable.pyright
    python3Packages.pytest
    python3Packages.black
    python3Packages.isort
    python3Packages.pyflakes
  ];
}
