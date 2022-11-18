{ pkgs, ... }:

{
  programs = {
    git = {
      userEmail = "jnorkus@evolution.com";
      signing.key = "2E6C9ABEFDF480C7";
    };
  };
}
