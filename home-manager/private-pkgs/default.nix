{ pkgs }:

{
  disable-mouse-acceleration = pkgs.callPackage ./expressions/disable-mouse-acceleration.nix { };
}
