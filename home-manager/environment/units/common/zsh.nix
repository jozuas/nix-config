{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000;
      size = 5000;
    };
    plugins = [
      {
        # Once home manager supports this manage through home-manager
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
    ];
    shellAliases = {
      ls = "ls -h --color=auto";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      vim = "nvim";
      vi = "nvim";
      cd = ">/dev/null cd";
      gg = "git ack";
      ggn = "git ack --no-index";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "xterm-256color";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      DIRENV_LOG_FORMAT = "";
      PATH = "$HOME/.npm-packages/bin:$HOME/.emacs.d/bin:$HOME/scripts:$PATH";
      ZSH_HIGHLIGHT_HIGHLIGHTERS="(main brackets cursor)";
    };
    initExtra = ''
      autoload -Uz promptinit
      promptinit
      prompt walters

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
        ${pkgs.ranger}/bin/ranger --choosedir="$tempfile" "$(pwd)"
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
