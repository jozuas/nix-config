{ config, pkgs, ... }:

{
  environment = {
    pathsToLink = [ "/libexec" ]; # i3wm

    systemPackages = with pkgs; [
      dconf
      libsecret # Gnome-Keyring
      gnome3.adwaita-icon-theme # Fallback theme
    ];
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  programs.seahorse.enable = true;

  services = {
    blueman.enable = true;

    gnome3.gnome-keyring.enable = true;

    # Mounting and Trash support for Nautilus
    gvfs.enable = true;
    udisks2.enable = true;

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
      };
    };
  };
}
