{ pkgs, ... }:

{
  programs = {
    git = {
      userEmail = "norkus@norkus.net";
      signing.key = "A1BC0103F3EE3ECE";
    };
  };
}
