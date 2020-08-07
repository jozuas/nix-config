{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry-qt
  ];

  services.gpg-agent = {
    pinentryFlavor = "qt";
  };

  home.sessionVariables = {
    TERMINAL = "konsole";
  };
}
