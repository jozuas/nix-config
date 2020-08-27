{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t480s>
    ./laptop-general.nix
  ];

  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/08e759d3-4463-42bc-817b-a025d2f840ba";
  };

  networking.interfaces = {
    enp0s31f6.useDHCP = true;
    wlp61s0.useDHCP = true;
  };

  services = {
    teamviewer.enable = true;
  };

  environment.systemPackages = with pkgs; [
    teamviewer
    zoom-us
    steam
  ];

  # Steam
  hardware = {
    opengl.driSupport32Bit = true;
    opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    pulseaudio.support32Bit = true;
  };

  # DPI>200 options to play with
  # fonts.fontconfig.antialias
  # fonts.fontconfig.subpixel.lcdfilter
}
