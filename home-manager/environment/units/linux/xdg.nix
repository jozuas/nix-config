{ pkgs, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "\$HOME/desktop";
      documents = "\$HOME/documents";
      download = "\$HOME/downloads";
      music = "\$HOME/music";
      pictures = "\$HOME/pictures";
      videos = "\$HOME/videos";
      templates = "\$HOME/templates";
      publicShare = "\$HOME/public";
    };
  };
}
