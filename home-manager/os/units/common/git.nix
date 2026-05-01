{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      package = pkgs.git;
      ignores = [
        "*.swp"
        ".ignore"
      ];
      settings = {
        user.name = "Juozas Norkus";
        alias = {
          "ack" = ''
            -c color.grep.linenumber="bold yellow"
            -c color.grep.filename="bold green"
            -c color.grep.match="reverse yellow"
            grep --break --heading --line-number
          '';
        };
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
          ff = "only";
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        branch = {
          sort = "-committerdate";
        };
        column = {
          ui = "auto";
        };
        push = {
          autoSetupRemote = true;
        };
        core = {
          editor = "nvim";
        };
        grep = {
          lineNumber = true;
          extendRegexp = true;
        };
        merge = {
          tool = "vimdiff";
        };
        mergetool = {
          prompt = false;
        };
        "mergetool \"vimdiff\"" = {
          cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          keepBackup = false;
          trustExitCode = false;
        };
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
