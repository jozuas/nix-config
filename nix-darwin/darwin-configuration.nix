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
      # "relaxed" sandboxes every build except derivations that explicitly opt
      # out with `__noChroot`, which are then only permitted for trusted users.
      # Needed because nixpkgs marks claude-code `__noChroot` on Darwin: its
      # prebuilt Bun binary can't execute under the macOS sandbox, so the
      # versionCheckHook fails. Nix's own Darwin default is `sandbox = false`,
      # so this is still stricter than stock.
      sandbox = "relaxed";
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
      # Don't `brew update` before installing. When Homebrew auto-updates it
      # re-execs itself with a stripped PATH, so Bundle can no longer find `mas`
      # and every `masApps` entry fails with "mas installation failed" (this
      # Homebrew has no .git, so it auto-updates on every run). Formula/cask
      # metadata is still refreshed from the API below, so `upgrade` stays
      # current; run `brew update` by hand to update Homebrew itself.
      autoUpdate = false;
      extraEnv.HOMEBREW_FORCE_API_AUTO_UPDATE = "1";
      upgrade = true; # upgrade outdated formulae/casks
      cleanup = "zap"; # delete any leftover config for packages not listed below
      # Recent Homebrew refuses `brew bundle install --cleanup` without an
      # explicit force flag; this nix-darwin version doesn't pass one, so add
      # it here. (Can drop once nix-darwin's homebrew module is updated.)
      extraFlags = [ "--force" ];
    };

    # Third-party taps. homebrew/core and homebrew/cask are built in and need no tap.
    taps = [
      "aaf2tbz/tap"
    ];

    # CLI formulae (`brew list`). `mas` is the Mac App Store CLI used for `masApps`.
    brews = [
      "mas"
    ];

    # GUI apps (`brew list --cask`).
    casks = [
      "alfred"
      "ungoogled-chromium"
      "betterdisplay"
      "calibre"
      "discord"
      "firefox@developer-edition"
      "linear"
      "notunes"
      "obsidian"
      "proton-mail"
      "proton-pass"
      "protonvpn"
      "rectangle"
      "shottr"
      "spotify"
      "sublime-merge"
      "tableplus"
      "tailscale-app"
      "transmission"
      "vlc"
      "wireshark-app"
      "zed"
      "paseo"
    ];

    # Mac App Store apps (`mas list`). Requires being signed into the App Store.
    # With `cleanup = "zap"`, current Homebrew Bundle *uninstalls* (moves to the
    # Trash) every App Store app not listed here as soon as this set is non-empty,
    # so it must list all of them. (nix-darwin's option docs still claim otherwise.)
    masApps = {
      "Affinity Designer 2" = 1616831348;
      "Affinity Photo 2" = 1616822987;
      "Affinity Publisher 2" = 1606941598;
      DigiDoc4 = 1370791134;
      Flighty = 1358823008;
      "Kagi Search" = 1622835804;
      LocalSend = 1661733229;
      "Magic Disk Benchmark" = 1608793370;
      "Microsoft Excel" = 462058435;
      "Microsoft Outlook" = 985367838;
      "Microsoft Word" = 462054704;
      OneDrive = 823766827;
      Parcel = 375589283;
      Pika = 6739170421; # paid ($2.99): buy it in the App Store first, mas can't purchase
      "Prime Video" = 545519333;
      Slack = 803453959;
      Telegram = 747648890; # native macOS client, updated by the App Store
      "Web eID" = 1576665083;
      WhatsApp = 310633997;
      Xcode = 497799835;
    };

    # Casks from third-party taps must be marked `trusted:` since Homebrew 6.
    # nix-darwin's `casks` option can't emit that key, and `onActivation.cleanup`
    # rewrites the trust store from the Brewfile on every activation, so a manual
    # `brew trust` would be discarded on the next switch.
    extraConfig = ''
      cask "aaf2tbz/tap/metalsharp", trusted: true
    '';
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
