{ config, pkgs, lib, ... }:

let
  username = "jnorkus";
  home = "/Users/${username}";
in {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup home-manager
  imports = [ <home-manager/nix-darwin> ];
  users.users.jnorkus.home = home;
  home-manager.users.jnorkus = (import ~/.config/nixpkgs/home.nix);

  nix = {
    gc.automatic = true; # Run nix-collect-garbage once a week
    settings = {
      auto-optimise-store = true; # Run nix-store --optimise

      # Binary caches
      substituters =
        [ "https://cache.nixos.org/" "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # nix-index is a tool to quickly locate the package providing a certain
  # certain file in nixpkgs. It indexes built derivations found in binary caches.
  programs.nix-index.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
