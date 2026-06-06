{
  pkgs,
  username,
  homeDirectory,
  ...
}:

{
  users.users.${username}.home = homeDirectory;

  system.primaryUser = username;

  environment.systemPackages = [
    pkgs.pam-reattach
  ];

  environment.etc = {
    # Symlink nixpkgs and nixpkgs-unstable to /etc for convenience
    "nixpkgs".source = "${pkgs.path}";
    "nixpkgs-unstable".source = "${pkgs.unstable.path}";

    # Hack to make pam-reattach work
    # Meanwhile waiting for the following to be merged
    # https://github.com/LnL7/nix-darwin/pull/1020
    "pam.d/sudo_local".text = ''
      # Written by nix-darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    '';
  };

  nix = {
    optimise.automatic = true; # Automatically run the nix store optimiser
    gc.automatic = true; # Run nix-collect-garbage once a week
    gc.options = "--delete-older-than 30d";

    nixPath = [
      "nixpkgs=/etc/nixpkgs"
      "nixpkgs-unstable=/etc/nixpkgs-unstable"
    ];

    settings = {
      # Cannot build livebook otherwise for now
      sandbox = false;
      trusted-users = [
        "root"
        username
      ];

      # Binary caches
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Declaratively manage an existing Homebrew installation. nix-darwin does not
  # install Homebrew itself, nor does it pull packages into the Nix store; on
  # each `darwin-rebuild switch` it runs `brew bundle` so the installed
  # brews/casks/taps match the lists below. This is useful for GUI/proprietary
  # apps that aren't in (or don't work well from) nixpkgs.
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # `brew update` before installing
      upgrade = true; # upgrade outdated formulae/casks
      cleanup = "zap"; # delete any leftover config for packages not listed below
      # Recent Homebrew refuses `brew bundle install --cleanup` without an
      # explicit force flag; this nix-darwin version doesn't pass one, so add
      # it here. (Can drop once nix-darwin's homebrew module is updated.)
      extraFlags = [ "--force" ];
    };

    # Third-party taps. homebrew/core and homebrew/cask are built in and need no tap.
    taps = [ ];

    # CLI formulae (`brew list`)
    brews = [
      "b2-tools"
      "git"
      "icu4c@77"
      "imagemagick"
    ];

    # GUI apps (`brew list --cask`).
    casks = [
      "alfred"
      "arc"
      "audacity"
      "betterdisplay"
      "calibre"
      "dash"
      "discord"
      "firefox@developer-edition"
      "ghostty"
      "iterm2"
      "linear"
      "microsoft-auto-update"
      "microsoft-office"
      "notunes"
      "obsidian"
      "pika"
      "proton-mail"
      "proton-pass"
      "protonvpn"
      "rectangle"
      "shottr"
      "spotify"
      "sublime-merge"
      "tableplus"
      "tailscale-app"
      "telegram-desktop"
      "transmission"
      "vlc"
      "wireshark-app"
      "zed"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

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
