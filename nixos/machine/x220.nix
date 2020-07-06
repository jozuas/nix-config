{ config, pkgs, ... }:

{
  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/ef379326-1cf6-4e91-bdff-b97fc21a8a6f";
  };

  networking = {
    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
      wwp0s29u1u4i6.useDHCP = true;
    };
  };
}
