{
  pkgs,
  repoLink,
  homeDirectory,
  ...
}:

{
  imports = [
    ./common.nix
    ./units/linux/alacritty.nix
    ./units/linux/gtk.nix
    ./units/linux/rofi.nix
    ./units/linux/xdg.nix
    ./units/linux/xorg.nix
  ];

  xdg.configFile."polybar/config".source = repoLink "dotfiles/polybar-config";
  xdg.configFile."i3/config".source = repoLink "dotfiles/i3-config";

  home.file.".xscreensaver".source = repoLink "dotfiles/xscreensaver-config";

  home.packages = with pkgs; [
    speedtest-cli

    # GUIs
    unstable.obsidian
    unstable.slack
    unstable.beekeeper-studio
    unstable.vscode
    spotify
    audacity
    unstable.telegram-desktop
    unstable.discord
    firefox-devedition

    pkgs.pick-colour-picker
    pkgs.simplescreenrecorder
    pkgs.zathura

    pkgs.totem
    pkgs.nautilus
    pkgs.cheese
    pkgs.transmission_4-gtk

    unstable.anydesk
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  services = {
    unclutter = {
      enable = true;
      package = pkgs.unclutter-xfixes;
    };
  };

  programs = {
    zsh = {
      enableVteIntegration = true;
      sessionVariables = {
        BROWSER = "${pkgs.firefox-devedition}/bin/firefox-devedition";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        CDPATH = ".:${homeDirectory}:${homeDirectory}/dev:${homeDirectory}/documents";
      };
    };

    ssh.enable = true;

    tmux = {
      extraConfig = ''
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
      '';
    };
  };
}
