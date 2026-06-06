{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  # Let Home Manager install and manage itself.
  # Only needed for MacOS.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.unstable.ghostty-bin
    pkgs.fontconfig
  ];

  # Allow fontconfig to discover fonts and configurations installed through
  # home.packages and nix-env
  fonts.fontconfig.enable = true;

  programs = {
    zsh = {
      sessionVariables = {
        DICTIONARY = "$HOME/Library/Spelling/en_GB";
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
