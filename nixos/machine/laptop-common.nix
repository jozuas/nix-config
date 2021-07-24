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

  services.cron = {
    enable = true;
    # Update caches everyday at midday
    systemCronJobs = [
      "0 12 * * * juozas echo 'Cronning' >> /tmp/cronout"
      "0 12 * * * juozas /home/juozas/.nix-profile/bin/tldr fd >> /tmp/cronout"  # TODO remove
      "0 12 * * * juozas /home/juozas/.nix-profile/bin/nox non-existing >> /tmp/cronout"
      "0 12 * * * juozas /run/current-system/sw/bin/nix search -u non-existing >> /tmp/cronout"
      "0 12 * * * juozas /home/juozas/.nix-profile/bin/tldr --update >> /tmp/cronout"
    ];
  };
}
