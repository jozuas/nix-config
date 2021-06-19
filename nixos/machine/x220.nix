{ pkgs, ... }:

let
  x220Layout = pkgs.writeText "xkb-layout" ''
    ! Make the ThinkVantage button a bluetooth toggle key
    keycode 156 = XF86Bluetooth

    ! Make Menu key a Print key to match t480s
    keycode 135 = Print
  '';
in
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x220>
    ./laptop-common.nix
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

  services = {
    udev.extraHwdb = ''
      LIBINPUT_MODEL_LENOVO_X220_TOUCHPAD_FW81=1
    '';

    xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${x220Layout}";
  };
}
