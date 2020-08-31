let
  pkgs = import <nixpkgs> {};
in with pkgs; {
  #deadd-notification-center = import ./expressions/deadd-notification-center.nix {
  #  inherit stdenv fetchurl autoPatchelfHook gtk3 gobject-introspection libxml2;
  #};

  deadd-notification-center = callPackage ./expressions/deadd-notification-center.nix {};
}
