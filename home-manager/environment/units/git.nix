{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "norkus@norkus.net";
    userName = "Juozas Norkus";
    signing.key = "6D11AC468819E2EA41232CB52FE519DA622AF155";
    signing.signByDefault = true;
    aliases = {
      "ack" = "-c color.grep.linenumber=\"bold yellow\" \
               -c color.grep.filename=\"bold green\" \
               -c color.grep.match=\"reverse yellow\" \
               grep --break --heading --line-number";
    };
    ignores = [ "*.swp" ];
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "less -x1,3";
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
}
