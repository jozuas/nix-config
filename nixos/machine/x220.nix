{ config, pkgs, ... }:

let
    x220Layout = pkgs.writeText "xkb-layout" ''
      ! Make ThinkVantage a bluetooth toggle key
      keycode 156 = XF86Bluetooth

      ! Make Menu key a Print key to match t480s
      keycode 135 = Print

      ! Make AltGR a return for ergonomics
      keycode 108 = Return
    '';
in
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x220>
  ];

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

  # TODO: ensure we use this package definition format everywhere
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${x220Layout}";
}
