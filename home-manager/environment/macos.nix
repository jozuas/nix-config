{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  home.packages = with pkgs; [
    htop
    fontconfig
    cloc
    # openjdk
  ];

  programs = {
    zsh = {
      sessionVariables = {
        DICTIONARY="$HOME/Library/Spelling/en_GB";
      };
    };
    tmux = {
      extraConfig = ''
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      '';
    };
  };
}
