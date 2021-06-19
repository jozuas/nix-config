{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bibata-cursors
    light
    feh
  ];

  programs = {
    git = {
      extraConfig = {
        credential.helper = "libsecret";
      };
    };
  };
}
