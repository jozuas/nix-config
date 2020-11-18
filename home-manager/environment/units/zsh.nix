{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
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
    };
    sessionVariables = {
      TERM = "xterm-256color";
      BROWSER = "${pkgs.firefox-devedition-bin}/bin/firefox-devedition";
      TERMINAL = "${pkgs.alacritty}/bin/alacritty";
      DIRENV_LOG_FORMAT = "";
      CDPATH = ".:/home/juozas:/home/juozas/dev:/home/juozas/documents";
      PATH = "$HOME/.npm-packages/bin:$PATH";
    };
    initExtra = ''
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
