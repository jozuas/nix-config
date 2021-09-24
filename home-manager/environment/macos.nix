{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  home.packages = with pkgs; [
    htop
    fontconfig
    cmake
  ];

  programs.zsh = {
    sessionVariables = {
      DICTIONARY="$HOME/Library/Spelling/en_GB";
    };
  };
}
