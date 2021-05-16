{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
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

    # Gets rid of screen tearing
    xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
    };
  };

  # nixpkgs.config.allowBroken = true;
  virtualisation.virtualbox.host = {
    enable = true;
    package = unstable.virtualbox;
  };

  users.extraGroups.vboxusers.members = [ "juozas" ];

  environment.systemPackages = with pkgs; [
    teamviewer
    zoom-us
  ];

  # DPI>200 options to play with
  # fonts.fontconfig.antialias
  # fonts.fontconfig.subpixel.lcdfilter
}
