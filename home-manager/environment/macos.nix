{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  home.packages = with pkgs; [
  ];

  programs = {
    git = {
      userEmail = "jnorkus@evolution.com";
    };
  };
}
