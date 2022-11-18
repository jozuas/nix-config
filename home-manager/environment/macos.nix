{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  home.packages = with pkgs; [
    htop
    fontconfig
    ansible
  ];

  programs = {
    zsh = {
      sessionVariables = {
        DICTIONARY="$HOME/Library/Spelling/en_GB";
        NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:$NIX_PATH";
      };
      initExtra = ''
        source $HOME/.iterm2_shell_integration.zsh
      '';
      shellAliases = {
        x86brew = "HOMEBREW_CELLAR=/usr/local/Cellar HOMEBREW_PREFIX=/usr/local HOMEBREW_REPOSITORY=/usr/local PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin arch -x86_64 /usr/local/bin/brew";
        essh = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
      };
    };
    tmux = {
      extraConfig = ''
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      '';
    };
  };
}
