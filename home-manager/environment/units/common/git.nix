{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Juozas Norkus";
    signing.signByDefault = true;
    aliases = {
      "ack" = ''
        -c color.grep.linenumber="bold yellow" 
                       -c color.grep.filename="bold green" 
                       -c color.grep.match="reverse yellow" 
                       grep --break --heading --line-number'';
    };
    ignores = [ "*.swp" ".ignore" ];
    extraConfig = {
      pull = { rebase = false; };
      core = { editor = "nvim"; };
      grep = {
        lineNumber = true;
        extendRegexp = true;
      };
      merge = { tool = "vimdiff"; };
      mergetool = { prompt = false; };
      "mergetool \"vimdiff\"" = {
        cmd =
          "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
        keepBackup = false;
        trustExitCode = false;
      };
    };
    delta.enable = true;
  };
}
