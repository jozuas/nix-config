{ pkgs, ... }:

let
  pkgs_unstable = import <nixpkgs-unstable> { };
in {
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
    pkgs_unstable.obsidian
    pkgs_unstable.slack
    pkgs_unstable.beekeeper-studio
    pkgs_unstable.vscode
    pkgs.spotify
    pkgs.audacity
    pkgs_unstable.tdesktop
    pkgs_unstable.discord
    pkgs.firefox-devedition-bin

    pkgs.pick-colour-picker
    pkgs.simplescreenrecorder
    pkgs.zathura

    pkgs.gnome3.totem
    pkgs.gnome3.nautilus
    pkgs.gnome3.cheese
    pkgs.transmission-gtk
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
