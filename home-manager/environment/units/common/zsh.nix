{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableVteIntegration = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000;
      size = 5000;
    };
    shellAliases = {
      cd = ">/dev/null cd";
      gg = "git ack";
      ggn = "git ack --no-index";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'";
    };
    sessionVariables = {
      TERM = "xterm-256color";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      DIRENV_LOG_FORMAT = "";
      PATH = "$HOME/.npm-packages/bin:$HOME/.emacs.d/bin:$PATH";
    };
    initExtra = ''
      bindkey -e

      # extra history config
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS

      # pushd
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_SILENT
      setopt PUSHD_TO_HOME

      function ranger-cd {
        tempfile=$(mktemp -t tmp.XXXXXX)
        /home/juozas/.nix-profile/bin/ranger --choosedir="$tempfile" "$(pwd)"
        test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(cat "$tempfile")"
        fi
        rm -f -- "$tempfile"
      }
      bindkey -s "^O" "ranger-cd\n"

      eval "$(direnv hook zsh)"
    '';
  };
}
