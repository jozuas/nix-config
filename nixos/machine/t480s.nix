{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t480s>
    ./laptop-general.nix
  ];

  # DPI>200 options to play with
  # fonts.fontconfig.antialias
  # fonts.fontconfig.subpixel.lcdfilter
}
