{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000;
      size = 5000;
    };
    cdpath =
      [ "$HOME" "$HOME/dev" "$HOME/.nix-defexpr/channels" ];
    shellAliases = {
      ls = "ls -h --color=auto";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      vim = "nvim";
      vi = "nvim";
      cd = ">/dev/null cd";
      nix-direnv-new = "nix flake new -t github:nix-community/nix-direnv";
      nix-stray-roots =
        "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "xterm-256color";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      DIRENV_LOG_FORMAT = "";
      PATH = "$HOME/.npm-packages/bin:$HOME/.emacs.d/bin:$HOME/scripts:$PATH";
      ZSH_HIGHLIGHT_HIGHLIGHTERS = "(main brackets cursor)";
      ERL_AFLAGS = "-kernel shell_history enabled";
      ERL_EPMD_ADDRESS = "127.0.0.1"; # By default epmd listens on 0.0.0.0
      NIXPKGS_ALLOW_BROKEN = "1";
    };
    initExtra = ''
      autoload -Uz promptinit
      promptinit
      prompt walters

      # print a newline before prompt
      # precmd() { print "" }

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
