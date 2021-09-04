{ pkgs, ... }:

{
  programs = {
    alacritty.settings = {
      font.size = 14;
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
    };

    zsh = {
      sessionVariables = {
        NIX_PATH="$HOME/.nix-defexpr/channels:$NIX_PATH";
      };
    };

    git = {
      userEmail = "jnorkus@evolution.com";
      signing.key = "2E6C9ABEFDF480C7";
    };
  };
}
