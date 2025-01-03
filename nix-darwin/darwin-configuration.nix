{ pkgs, ... }:

let
  username = "juozas";
  home = "/Users/${username}";
in {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup home-manager
  imports = [ <home-manager/nix-darwin> ];
  users.users.juozas.home = home;
  home-manager.users.juozas = import ~/.config/nixpkgs/home.nix;

  environment.systemPackages = [
    pkgs.pam-reattach
  ];

  # Hack to make pam-reattach work
  # Meanwhile waiting for the following to be merged
  # https://github.com/LnL7/nix-darwin/pull/1020
  environment.etc."pam.d/sudo_local".text = ''
    # Written by nix-darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
  '';

  nix = {
    optimise.automatic = true; # Automatically run the nix store optimiser
    gc.automatic = true; # Run nix-collect-garbage once a week

    settings = {
      trusted-users = [ "root" "juozas" ];

      # Binary caches
      substituters =
        [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
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
