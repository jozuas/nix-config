{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      extraConfig = {
        credential.helper = "libsecret";
      };
    };
  };
}
