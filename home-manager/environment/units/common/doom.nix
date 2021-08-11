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
    # TODO this, for e.g. is used in vim as well
    # TODO ag is used by projectile ...
    hunspell

    # Nix
    nixfmt

    # Erlang
    erlang-ls

    # Markdown
    mdl
    proselint
    pandoc

    # Python
    python-language-server
    python3Packages.pytest
    python3Packages.black
    python3Packages.isort
    python3Packages.pyflakes
  ];
}
