let
  pkgs = import <nixpkgs> { };
in
with pkgs;
{
  disable-mouse-acceleration = callPackage ./expressions/disable-mouse-acceleration.nix { };
}
