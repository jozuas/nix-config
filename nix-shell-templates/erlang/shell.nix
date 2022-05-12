{ pkgs ? import <nixpkgs> {}}:

let
  lib = pkgs.callPackage <nixpkgs/pkgs/development/beam-modules/lib.nix> {};

  R25drv = { mkDerivation } : mkDerivation {
     version = "25.0-rc3";
     sha256 = "1ir42hz81bzxn1shqq0gn824hxd6j774889vjy68psi95psfs8r2";
  };

  R25args = {
    parallelBuild = true;
    wxSupport = false;
    systemdSupport = false;
  };

  R25 = lib.callErlang R25drv R25args;
in pkgs.mkShell {
  buildInputs = with pkgs; [
    R25
  ];
}
