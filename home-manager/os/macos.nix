{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  # Let Home Manager install and manage itself.
  # Only needed for MacOS.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    htop
    fontconfig
  ];

  # Allow fontconfig to discover fonts and configurations installed through
  # home.packages and nix-env
  fonts.fontconfig.enable = true;

  programs = {
    zsh = {
      sessionVariables = {
        DICTIONARY = "$HOME/Library/Spelling/en_GB";
        NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:$NIX_PATH";
      };
      initExtra = ''
        source $HOME/.iterm2_shell_integration.zsh
      '';
      shellAliases = {
        x86brew = "HOMEBREW_CELLAR=/usr/local/Cellar HOMEBREW_PREFIX=/usr/local HOMEBREW_REPOSITORY=/usr/local PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin arch -x86_64 /usr/local/bin/brew";
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
