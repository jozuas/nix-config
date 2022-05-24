{ pkgs, ... }:

{
  programs = {
    zsh = {
      sessionVariables = {
        NIX_PATH="$HOME/.nix-defexpr/channels:$NIX_PATH";
      };
    };

    git = {
      userEmail = "jnorkus@evolution.com";
      signing.key = "2E6C9ABEFDF480C7";
    };

    zsh = {
      initExtra = ''
        source $HOME/.iterm2_shell_integration.zsh
      '';
    };
  };
}
