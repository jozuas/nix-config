{ config, pkgs, ... }:

{
  environment = {
    pathsToLink = ["/libexec"];  # i3wm

    systemPackages = with pkgs; [
      dconf
    ];
  };

  services = {
    blueman.enable = true;

    gnome3 = {
      gnome-keyring.enable = true;
      seahorse.enable = true;
    };

    pam.services.lighdm.enable = true;

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
