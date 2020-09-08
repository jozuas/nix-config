let
  pkgs = import <nixpkgs> {};
in with pkgs; {
  deadd-notification-center = callPackage ./expressions/deadd-notification-center.nix {};
  disable-mouse-acceleration = callPackage ./expressions/disable-mouse-acceleration.nix {};
}
