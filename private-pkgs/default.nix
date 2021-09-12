let
  pkgs = import <nixpkgs> {};
in with pkgs; {
  disable-mouse-acceleration = callPackage ./expressions/disable-mouse-acceleration.nix {};
  s4 = callPackage ./expressions/S4.nix {};
}
