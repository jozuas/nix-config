{
  config,
  pkgs,
  ...
}:

{
  imports = [ ./common.nix ];

  # Let Home Manager install and manage itself.
  # Only needed for MacOS.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.unstable.ghostty-bin
    pkgs.fontconfig
    pkgs.pinentry_mac
    pkgs.imagemagick
    # nixpkgs renames the binary to `backblaze-b2` (Boost also ships a `b2`)
    (pkgs.unstable.backblaze-b2.override { execName = "b2"; })
  ];

  # Resolve pinentry through the profile symlink instead of the store path
  # gpg-agent would otherwise bake in at startup, so an agent that outlives a
  # `nix.gc` run can still find it.
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${config.home.profileDirectory}/bin/pinentry-mac
  '';

  # Allow fontconfig to discover fonts and configurations installed through
  # home.packages and nix-env
  fonts.fontconfig.enable = true;

  programs = {
    zsh = {
      sessionVariables = {
        DICTIONARY = "$HOME/Library/Spelling/en_GB";
        # nixpkgs' claude-code wrapper defaults this to "system", which on
        # macOS only picks up the keychain's custom CAs, not Apple's public
        # roots, so TLS to api.anthropic.com fails. Keep the bundled roots too.
        CLAUDE_CODE_CERT_STORE = "bundled,system";
      };
      shellAliases = {
        ussh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
        uscp = "scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
      };
    };
    tmux = {
      extraConfig = ''
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      '';
    };
  };
}
