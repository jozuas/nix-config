# Core System-wide configuration.

{ pkgs, ... }:

let
  home = "/home/juozas";
in
{
  imports = [
    ./state-version.nix
    ./hardware-configuration.nix
    ./machine/t480s.nix
    ./desktop/i3.nix

    <home-manager/nixos>
  ];

  boot = {
    kernel.sysctl = { "vm.swappiness" = 1; };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      timeout = 3;
      efi.canTouchEfiVariables = true;
    };

    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";
    tcpcrypt.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ 51820 ];
    };

    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ "10.0.0.1/24" ];
          listenPort = 51820; # to match firewall allowedUDPPorts (wg uses random port numbers by default)
          privateKeyFile = "/etc/wireguard/private.key";

          peers = [
            {
              ## Terrapin ##
              publicKey = "R7+sWoJON9sEsLzqY19N5qV5txZCj6Y1mb0ckckr2gI=";
              endpoint = "167.235.148.205:51820";
              allowedIPs = [ "10.0.0.0/16" ]; # Forward only subnet traffic
              persistentKeepalive = 20; # Important to keep NAT tables alive.
            }
          ];
        };
      };
    };

    hosts = { "192.168.1.42" = [ "pi" ]; };
  };

  # Localisation
  time.timeZone = "Europe/Lisbon";
  location.provider = "geoclue2";
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  fonts = {
    fonts = with pkgs; [ dejavu_fonts ubuntu_font_family corefonts nerdfonts ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "DejaVu Sans Mono" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };
  };

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-ocl
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      daemon.config = {
        default-sample-format = "float32le";
        default-sample-rate = "48000";
        alternate-sample-rate = "44100";
        default-sample-channels = "2";
        default-channel-map = "front-left,front-right";
        default-fragments = "2";
        default-fragment-size-msec = "125";
        resample-method = "soxr-vhq";
        enable-lfe-remixing = "no";
        high-priority = "yes";
        nice-level = "-11";
        realtime-scheduling = "yes";
        realtime-priority = "9";
        rlimit-rtprio = "9";
        daemonize = "no";
      };
    };
  };

  sound.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = "nix-command flakes";
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      inotify-tools
      killall
      file
      traceroute
      htop
      openvpn
      zip
      unzip
      binutils
      whois
      curl
      nix-index
    ];
  };

  programs = {
    zsh = { enable = true; };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    steam.enable = true;
  };

  services = {
    xserver = {
      # Support for most mice and keyboards
      libinput.enable = true;

      # Enable the X11 windowing system.
      enable = true;

      layout = "gb";
      # layout = "gb,ru";
      # xkbVariant = ",phonetic_winkeys";

      xkbOptions = "compose:ralt,caps:escape,grp:switch,grp:alt_space_toggle";
    };
  };

  system.autoUpgrade.enable = true;

  users.users.tcpcryptd.group = "tcpcryptd";
  users.groups.tcpcryptd = { };

  users.defaultUserShell = pkgs.zsh;
  users.users.juozas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" "networkmanager" "video" "vboxusers" ];
    home = home;
  };

  # Setup home-manager
  home-manager.users.juozas = (import "${home}/.config/nixpkgs/home.nix");
}
