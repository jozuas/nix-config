{ config, pkgs, ... }:

{
  environment = {
    pathsToLink = ["/libexec"];  # i3wm

    systemPackages = with pkgs; [
      dconf
      libsecret
    ];
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  programs.seahorse.enable = true;

  services = {
    blueman.enable = true;

    gnome3.gnome-keyring.enable = true;

    xserver = {
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        lightdm.greeters.mini = {
          enable = true;
          user = "juozas";
          extraConfig = ''
            [greeter]
            show-password-label = false
            [greeter-theme]
            background-image = "/usr/share/backgrounds/forest.jpg"
          '';
        };
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
        ];
      };
    };
  };
}
