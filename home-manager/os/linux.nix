{ config, pkgs, pkgs-unstable, ... }:

let
  repoLink = path:
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/${path}";
in
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
  xdg.configFile."deadd/deadd.conf".source = repoLink "dotfiles/deadd.conf";
  xdg.configFile."deadd/deadd.css".source = repoLink "dotfiles/deadd.css";

  home.file.".xscreensaver".source = repoLink "dotfiles/xscreensaver-config";
  home.file.".background-image".source = repoLink "resources/backgrounds/forest.jpg";
  home.file.".doom.d".source = repoLink "dotfiles/doom";

  home.packages = with pkgs; [
    rclone
    nmap
    speedtest-cli

    # GUIs
    pkgs-unstable.obsidian
    pkgs-unstable.slack
    pkgs-unstable.beekeeper-studio
    pkgs-unstable.vscode
    pkgs.spotify
    pkgs.audacity
    pkgs-unstable.tdesktop
    pkgs-unstable.discord
    pkgs.firefox-devedition-bin

    pkgs.pick-colour-picker
    pkgs.simplescreenrecorder
    pkgs.zathura

    pkgs.gnome3.totem
    pkgs.gnome3.nautilus
    pkgs.gnome3.cheese
    pkgs.transmission-gtk

    pkgs-unstable.anydesk
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
        BROWSER = "${pkgs.firefox-devedition-bin}/bin/firefox-devedition";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        CDPATH = ".:/home/juozas:/home/juozas/dev:/home/juozas/documents";
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
