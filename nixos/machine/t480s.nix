{ pkgs, ... }:

let pkgs_unstable = import <nixpkgs-unstable> { };
in {
  imports = [ <nixos-hardware/lenovo/thinkpad/t480s> ./laptop-common.nix ];

  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/08e759d3-4463-42bc-817b-a025d2f840ba";
  };

  networking.interfaces = {
    enp0s31f6.useDHCP = true;
    wlp61s0.useDHCP = true;
  };

  services = {
    # Gets rid of screen tearing
    xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
    };
  };

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
