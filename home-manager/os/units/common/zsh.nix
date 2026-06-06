{ pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/.npm-packages/bin"
    "$HOME/scripts"
  ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000;
      size = 5000;
    };
    cdpath = [
      "$HOME"
      "$HOME/dev"
      "/Volumes"
    ];
    shellAliases = {
      ls = "ls -h --color=auto";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      vim = "nvim";
      vi = "nvim";
      cd = ">/dev/null cd";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/w+-system|{memory)'";
    };
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      EDITOR = "nvim";
      VISUAL = "nvim";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      ZSH_HIGHLIGHT_HIGHLIGHTERS = "(main brackets cursor)";
      ERL_AFLAGS = "-kernel shell_history enabled";
      ERL_EPMD_ADDRESS = "127.0.0.1"; # By default epmd listens on 0.0.0.0
      NIXPKGS_ALLOW_BROKEN = "1";
    };
    initContent = ''
      PROMPT='%B%(?..[%?] )%b%~ > '

      bindkey -e

      # extra history config
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS

      # pushd
      setopt PUSHD_IGNORE_DUPS
      setopt PUSHD_SILENT
      setopt PUSHD_TO_HOME

      function yazi-cd {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        ${pkgs.yazi}/bin/yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        command rm -f -- "$tmp"
      }
      bindkey -s "^O" "yazi-cd\n"

      # b2-cli is crapping out without this with a buffer overflow
      # https://github.com/Backblaze/B2_Command_Line_Tool/issues/1119
      export LINES; export COLUMNS;

      eval "$(direnv hook zsh)"
    '';
  };
}
