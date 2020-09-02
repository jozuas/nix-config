{ pkgs, ... }:

let
  fdExclude = "--exclude .git --exclude node_modules --exclude result";
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f ${fdExclude}";
    defaultOptions = [
      "--exact"
      "--no-mouse"
      "--height 50%"
      "--reverse"
      "--tabstop=4"
      "--color=16"
      "--inline-info"
      "--preview-window 'down:95%:wrap:hidden'"
      "--bind ctrl-p:toggle-preview,alt-k:preview-up,alt-j:preview-down"
    ];
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d ${fdExclude}";
    changeDirWidgetOptions = [
      "--preview '${pkgs.tree}/bin/tree -C {} | head -200'"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f ${fdExclude}";
    fileWidgetOptions = [
      "--preview '(${pkgs.bat}/bin/bat --color=always {} || cat {}) 2> /dev/null'"
    ];
  };
}
