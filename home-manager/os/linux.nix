{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
    ./units/linux/alacritty.nix
    ./units/linux/gtk.nix
    ./units/linux/rofi.nix
    ./units/linux/xdg.nix
    ./units/linux/xorg.nix
  ];

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
