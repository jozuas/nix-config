# Configuration options commonly shared between laptops

{ pkgs, ... }:

{
  boot.initrd.luks.devices.root = {
    preLVM = true;        # First lukOpen, then LVM scan
    allowDiscards = true; # Enable TRIM requests
  };

  # SSD performance fine-tuning
  fileSystems."/".options = [ "noatime" "nodiratime" "commit=60" ];

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
      wifi.powersave = true;
    };
  };

  hardware = {
    acpilight.enable = true; # Enable the use of xbacklight
    brillo.enable = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    # Periodic SSD trimming for sustained long-term SSD performance
    fstrim.enable = true;
    fstrim.interval = "weekly";

    tlp.enable = true;
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "juozas" ];
        runAs = "root";
        commands = [
          {
            command = "/run/current-system/sw/bin/bluetooth";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
